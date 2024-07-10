import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboarding_app/Screens/qr_scanner/controller/controller.dart';
import 'package:onboarding_app/utility/constant.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../form/registration_form.dart';
class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}




class _QRScannerState extends State<QRScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  QrDataController con=Get.put(QrDataController());

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        ()=> Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
            Expanded(
              flex: 1,
              child:  Center(
                  child: Text("${con.qrData.value}"),
                ),
            )
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
     con.setQrData(scanData.code.toString());

     Get.off(RegistrationForm(code: scanData.code.toString(),));
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

