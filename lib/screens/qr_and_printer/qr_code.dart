import 'package:digital_weighbridge/configs/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCode extends StatefulWidget {
  const QrCode({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

 // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    bool isAndroid = Theme
        .of(context)
        .platform == TargetPlatform.android;
    if (isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                if (result != null)
                  Text(
                      'Barcode Type: ${describeEnum(
                          result!.format)}   Data: ${result!.code}')
                else
                  const Text('Scan a code'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        await controller?.toggleFlash();
                        setState(() {});
                      },
                      child: Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: bgColor,
                          ),
                          child: FutureBuilder(
                            future: controller?.getFlashStatus(),
                            builder: (context, snapshot) {
                              return snapshot.data == true ? Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Flash:',style: TextStyle(color: Colors.white),),
                                  Icon(Icons.flash_on,color: Colors.white,)
                                ],):Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Flash:',style: TextStyle(color: Colors.white),),
                                  Icon(Icons.flash_off,color: Colors.white,)
                                ],);
                              //return snapshot.data == true? Center(child: Text('Flash: ${snapshot.data}',style: TextStyle(color: Colors.white),));
                            },
                          )
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await controller?.flipCamera();
                        setState(() {});
                      },
                      child: Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: bgColor,
                          ),
                          child: FutureBuilder(
                            future: controller?.getCameraInfo(),
                            builder: (context, snapshot) {
                              if (snapshot.data != null) {
                                return Center(
                                  child: Text(
                                    '${describeEnum(snapshot.data!)} Camera',
                                    style: TextStyle(color: Colors.white),),
                                );
                              } else {
                                return Center(child: const Text('loading'));
                              }
                            },
                          )
                      ),
                    )
                  ],
                ),
              ],
            ),

          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery
        .of(context)
        .size
        .width < 400 ||
        MediaQuery
            .of(context)
            .size
            .height < 400)
        ? 250.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    print('object');
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    print("pppppppppppppppppp");
    print(p);
    print('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
      // NavigationServices.goNextAndDoNotKeepHistory(
      //     context: context, widget: HomeScreen());
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}