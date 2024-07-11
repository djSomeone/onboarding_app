import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onboarding_app/Screens/qr_scanner/controller/controller.dart';
import 'package:onboarding_app/modules/popUp_model/invaildQrPop.dart';
import 'package:onboarding_app/modules/popUp_model/successfull_popup.dart';
import 'package:onboarding_app/utility/constant.dart';
// import 'package:onboarding_app/waitingPopUp/waitingPopUp.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../main.dart';
import '../../modules/popUp_model/waitingPopUp.dart';
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
  QrDataController con = Get.put(QrDataController());

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
      extendBody: true,
      // backgroundColor: ConstColor.primery,
      appBar: standeredAppBar(title: "Scan QR Code", enableBackButton: true),
      body: Stack(
        children: <Widget>[
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
          Center(
              child: Image(
            image: AssetImage("asset/qr.png"),
          )),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
      var finalId=getIdOnly(scanData.code.toString());
      con.setQrData(finalId);
      con.setRegistered();
      showDialog(
        barrierDismissible: false,
          context: context,
          builder: (context) {

            return Obx(
              ()=>
              con.isRegistered.value?AlertDialog(title: Text("Already Reagistered"),
                actions: [
               ElevatedButton(
                   style: ElevatedButton.styleFrom(
                     backgroundColor: ConstColor.primery, // Set your desired color here
                     // Set text color (optional)
                   ),
                   onPressed: (){
                 controller.resumeCamera();
                 Navigator.pop(context);
                 Navigator.pop(context);
               }, child: Text("Ok",style: TextStyle(color: Colors.white),),
               )],)
              :WaitingPopup(),
            );
          });

      

      // Get.off(RegistrationForm(code: scanData.code.toString(),));
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
