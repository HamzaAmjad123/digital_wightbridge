import 'package:bluetooth_thermal_printer/bluetooth_thermal_printer.dart';
import 'package:digital_weighbridge/helper_services/navigation_services.dart';
import 'package:digital_weighbridge/models/order_model.dart';
import 'package:digital_weighbridge/screens/home/home_screen.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';

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
    WidgetsBinding.instance
        .addPostFrameCallback((_) =>
        getBluetooths(),
    );
    setState(() {});
  }

  Future getBluetooths()async{
    await getBluetooth();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        NavigationServices.goNextAndDoNotKeepHistory(
            context: context, widget: HomeScreen());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: bgColor,
          title: Text(
            "Printer Screen",
            style: TextStyle(color: Colors.white,fontSize: 18),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              NavigationServices.goNextAndDoNotKeepHistory(
                  context: context, widget: HomeScreen());
            },
          ),
        ),
        body: Container(
          child: Center(
            child: Text( "No Bluetooth Printer Connect",
         style: TextStyle(color: bgColor, fontSize: 18),)
          ),
          // child: availableBluetoothDevices == 0
          //     ? Center(
          //   child: Text(
          //     "No Bluetooth Device Connect",
          //     style: TextStyle(color: bgColor, fontSize: 18),
          //   ),
          // )
          //     : ListView.builder(
          //     shrinkWrap: true,
          //     primary: false,
          //     itemCount: availableBluetoothDevices.length,
          //     itemBuilder: (context,index){
          //       return ListTile(
          //         leading: Icon(Icons.bluetooth,color: bgColor,),
          //         title: Text(availableBluetoothDevices[index]),
          //       );
          //     }),
        )
      ),
    );
  }

  //For Printer all methods and Variables

  //Function of Bluetooth printer
  Future<void> getBluetooth() async {
    final List? bluetooths = await BluetoothThermalPrinter.getBluetooths;
    availableBluetoothDevices = bluetooths!;
    setState(() {});
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

    // Print QR Code using native function
    bytes += generator.qrcode('Weight: 2500 kg,Total Wieght: 2000.com',
        size: QRSize(12));

    bytes += generator.hr();

    // Print Barcode using native function
    final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
    bytes += generator.barcode(Barcode.upcA(barData));

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
    bytes += generator.text(
      "For Kitchen",
      styles: PosStyles(
        align: PosAlign.center,
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ),
    );
    bytes += generator.hr(ch: '=', len: 32, linesAfter: 0);
    bytes += generator.row([
      PosColumn(
          text: 'name',
          width: 2,
          styles: PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: 'Qty',
          width: 2,
          styles: PosStyles(align: PosAlign.center, bold: true)),
      PosColumn(
          text: 'u-price',
          width: 2,
          styles: PosStyles(align: PosAlign.center, bold: true)),
      PosColumn(
          text: 'price',
          width: 2,
          styles: PosStyles(align: PosAlign.right, bold: true)),
      PosColumn(
          text: '',
          width: 4,
          styles: PosStyles(align: PosAlign.right, bold: false)),
    ]);
    bytes += generator.row([
      PosColumn(
          text: '',
          width: 2,
          styles: PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: '',
          width: 2,
          styles: PosStyles(align: PosAlign.center, bold: false)),
      PosColumn(
          text: '',
          width: 2,
          styles: PosStyles(align: PosAlign.center, bold: false)),
      PosColumn(
          text: '',
          width: 2,
          styles: PosStyles(align: PosAlign.right, bold: false)),
      PosColumn(
          text: '',
          width: 4,
          styles: PosStyles(align: PosAlign.right, bold: false)),
    ]);

    bytes += generator.hr(len: 32);
    bytes += generator.row([
      PosColumn(
          text: 'Sub Total',
          width: 3,
          styles: PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: '',
          width: 1,
          styles: PosStyles(align: PosAlign.center, bold: false)),
      PosColumn(
          text: '',
          width: 2,
          styles: PosStyles(align: PosAlign.center, bold: false)),
      PosColumn(
          text: 'total',
          width: 2,
          styles: PosStyles(align: PosAlign.right, bold: true)),
      PosColumn(
          text: '',
          width: 4,
          styles: PosStyles(align: PosAlign.right, bold: false)),
    ]);
    bytes += generator.cut();
    print("complete");
    print(bytes);
    return bytes;
  }
}
