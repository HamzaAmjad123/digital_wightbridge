import 'package:bluetooth_thermal_printer/bluetooth_thermal_printer.dart';
import 'package:digital_weighbridge/helper_services/custom_snacbar.dart';
import 'package:digital_weighbridge/helper_services/navigation_services.dart';
import 'package:digital_weighbridge/models/order_model.dart';
import 'package:digital_weighbridge/screens/home/home_screen.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../configs/colors.dart';

class PrinterScreen extends StatefulWidget {
  OrderModel? order;
  PrinterScreen({this.order});

  @override
  State<PrinterScreen> createState() => _PrinterScreenState();
}

class _PrinterScreenState extends State<PrinterScreen> {
  bool connected = false;
  List availableBluetoothDevices = [];
  List<int>? bytes = [];
  int connected_index = -1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => getPermissions(),
    );
    setState(() {});
  }

  Future getPermissions() async {
    await permissionServiceCall();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        NavigationServices.goNextAndDoNotKeepHistory(
            context: context, widget: HomeScreen());
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: bgColor,
            title: Text(
              "Printer Screen",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                NavigationServices.goNextAndDoNotKeepHistory(
                    context: context, widget: HomeScreen());
              },
            ),
          ),
          bottomNavigationBar: Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
                color: bgColor,
              ),
              // ignore: deprecated_member_use
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: MaterialButton(
                  onPressed: () async {
                    if (connected == true) {
                      await printTicket();
                      await printGraphics();
                      CustomSnackBar.showSnackBar(
                          context: context,
                          message: "Plaese Wait Recipet Printing");
                    } else {
                      CustomSnackBar.failedSnackBar(
                          context: context, message: "No Device Connected");
                    }
                  },
                  child: Center(
                    child: availableBluetoothDevices.length > 0
                        ? Text(
                            'Print Your Recipet',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          )
                        : Text(
                            "No Device Connect",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
              )),
          body: Container(
            child: availableBluetoothDevices == 0
                ? Center(
                    child: Text(
                      "No Bluetooth Device Connect",
                      style: TextStyle(color: bgColor, fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: availableBluetoothDevices.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          print("clicked");
                          String select = availableBluetoothDevices[index];
                          List list = select.split("#");
                          String mac = list[1];
                          this.setConnect(mac, index);
                          setState(() {
                          });
                        },
                        child: ListTile(
                            leading: Icon(
                              Icons.bluetooth,
                              color: bgColor,
                            ),
                            title: Text(availableBluetoothDevices[index]),
                            subtitle: connected_index == index
                                ? Text(
                                    "Connected",
                                    style: TextStyle(color: bgColor),
                                  )
                                : Text(
                                    "Click To connect with Device",
                                    style: TextStyle(color: Colors.black),
                                  )),
                      );
                    }),
          )),
    );
  }

  //For Printer all methods and Variables

  //Function of Bluetooth printer
  Future<void> getBluetooth() async {
    final List? bluetooths = await BluetoothThermalPrinter.getBluetooths;
    availableBluetoothDevices = bluetooths!;
    setState(() {});
    print("avalible BlueTooths");
    print(availableBluetoothDevices.length);
  }

  Future<void> setConnect(String mac, int x) async {
    final String? result = await BluetoothThermalPrinter.connect(mac);
    if (result == "true") {
      connected_index = x;
      connected = true;
      setState(() {});
    }
  }

  Future<void> printTicket() async {
    String? isConnected = await BluetoothThermalPrinter.connectionStatus;
    if (isConnected == "true") {
      List<int> bytes = await getTicket();
      final result = await BluetoothThermalPrinter.writeBytes(bytes);
      setState(() {});
    } else {
      //Hadnle Not Connected Senario
    }
  }

  Future<void> printGraphics() async {
    String? isConnected = await BluetoothThermalPrinter.connectionStatus;
    if (isConnected == "true") {
      List<int> bytes = await getGraphicsTicket();
      final result = await BluetoothThermalPrinter.writeBytes(bytes);
      print("Print $result");
    } else {
      //Hadnle Not Connected Senario
    }
  }

  Future<List<int>> getGraphicsTicket() async {
    List<int> bytes = [];

    CapabilityProfile profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);

    //Print QR Code using native function
    bytes += generator.qrcode(
        'TotalWeight' +
            widget.order!.totalWieght! +
            'Product Weight' +
            widget.order!.productWeight! +
            'weightType' +
            widget.order!.weightType! +
            '',
        size: QRSize(12));
    bytes += generator.hr();
    bytes += generator.cut();
    return bytes;
  }

  Future<List<int>> getTicket() async {
    List<int> bytes = [];
    CapabilityProfile profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    bytes += generator.text(
      "WightBridge",
      styles: PosStyles(
        align: PosAlign.center,
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ), /*linesAfter: 1*/
    );
    bytes += generator.text("Lahore Garrison Universty, Lahore",
        styles: PosStyles(align: PosAlign.center));
    bytes += generator.text('Fyp}',
        styles: PosStyles(
            align: PosAlign.left,
            height: PosTextSize.size1,
            width: PosTextSize.size2));
    bytes += generator.text('',
        styles: PosStyles(
            align: PosAlign.left,
            height: PosTextSize.size1,
            width: PosTextSize.size2));
    bytes += generator.hr(ch: '=', len: 32, linesAfter: 0);
    bytes += generator.text('Name:' + widget.order!.name!,
        styles: PosStyles(align: PosAlign.left, bold: true));
    bytes += generator.text('vehicle Type:' + widget.order!.vehcileType!,
        styles: PosStyles(align: PosAlign.left, bold: true));
    bytes += generator.text('Vehicle Name:' + widget.order!.vehicleName!,
        styles: PosStyles(align: PosAlign.left, bold: true));
    bytes += generator.text('Vehicle load:' + widget.order!.vehicleWeight!,
        styles: PosStyles(align: PosAlign.left, bold: true));
    bytes += generator.text('Product Weight:' + widget.order!.productWeight!,
        styles: PosStyles(align: PosAlign.left, bold: true));
    bytes += generator.text('Total wieght:' + widget.order!.totalWieght!,
        styles: PosStyles(align: PosAlign.left, bold: true));
    bytes += generator.text('Weight Type:' + widget.order!.weightType!,
        styles: PosStyles(align: PosAlign.left, bold: true));
    bytes += generator.hr(len: 32);
    bytes += generator.hr(ch: '=', len: 32, linesAfter: 0);
    // bytes += generator.cut();
    print("complete");
    print(bytes);
    return bytes;
  }

  Future<Map<Permission, PermissionStatus>> permissionServices() async {
    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      //add more permission to request here.
    ].request();
    if (statuses[Permission.bluetooth]!.isPermanentlyDenied) {
      await openAppSettings().then(
        (value) async {
          if (value) {
            if (await Permission.bluetooth.status.isPermanentlyDenied == true &&
                await Permission.bluetooth.status.isGranted == false) {
              openAppSettings();
              // permissionServiceCall(); /* opens app settings until permission is granted */
            }
          }
        },
      );
    } else {
      if (statuses[Permission.bluetooth]!.isDenied) {
        permissionServiceCall();
      }
    }
    if (statuses[Permission.bluetoothScan]!.isPermanentlyDenied) {
      await openAppSettings().then(
        (value) async {
          if (value) {
            if (await Permission.bluetoothScan.status.isPermanentlyDenied ==
                    true &&
                await Permission.bluetoothScan.status.isGranted == false) {
              openAppSettings();
              // permissionServiceCall(); /* opens app settings until permission is granted */
            }
          }
        },
      );
    } else {
      if (statuses[Permission.bluetoothScan]!.isDenied) {
        permissionServiceCall();
      }
    }

    if (statuses[Permission.bluetoothConnect]!.isPermanentlyDenied) {
      await openAppSettings().then(
        (value) async {
          if (value) {
            if (await Permission.bluetoothConnect.status.isPermanentlyDenied ==
                    true &&
                await Permission.bluetoothConnect.status.isGranted == false) {
              openAppSettings();
              // permissionServiceCall(); /* opens app settings until permission is granted */
            }
          }
        },
      );
      //openAppSettings();
      //setState(() {});
    } else {
      if (statuses[Permission.bluetoothConnect]!.isDenied) {
        permissionServiceCall();
      }
    }
    return statuses;
  }

  permissionServiceCall() async {
    await permissionServices().then(
      (value) async {
        if (value != null) {
          if (value[Permission.bluetooth]!.isGranted &&
              value[Permission.bluetoothConnect]!.isGranted &&
              value[Permission.bluetoothScan]!.isGranted) {
            /* ========= New Screen Added  ============= */
            await getBluetooth();
            setState(() {});
          }
        }
      },
    );
  }
}
