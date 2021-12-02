import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scp682/constants/colors.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({Key? key}) : super(key: key);

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {

  final qrKey = const Key("qrKey");
  QRViewController? qrViewController;

  @override
  void dispose() {
    qrViewController!.dispose();
    super.dispose();
  }

  @override
  void reassemble()async {
    if(Platform.isAndroid){
      await qrViewController!.pauseCamera();
    }
    qrViewController!.resumeCamera();
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: (controller) {
              setState(() {
                qrViewController = controller;
                qrViewController!.scannedDataStream.listen((barcode) {
                  if(barcode!=null)
                    {
                      ///SEND TO ADD INTO FAMILY AND THEN PUSH HOME
                    }
                });
              });
            },
            overlay: QrScannerOverlayShape(
              borderRadius: 15,
              borderColor: blue,
              cutOutSize: MediaQuery.of(context).size.width * 0.8,
            ),
          )
        ],
      ),
    ));
  }
}
