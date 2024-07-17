import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:onboarding_app/popUp_model/successfull_popup.dart';
import 'package:onboarding_app/utility/constant.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'Screens/qr_scanner/qr_scanner_screen.dart';
import 'api/api.dart';
import 'modules/popUp_model/invaildQrPop.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Api.dio.interceptors.add(PrettyDioLogger());
    Api.dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Color(0xFF004AAD),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Register QR Code",style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(200, 50),
            backgroundColor: ConstColor.primery, // Set your desired color here
            // Set text color (optional)
          ),
          onPressed: () {
            toast(msg: "clicked");
            Get.to(QRScanner());
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.qr_code_scanner,color: Colors.white),
              Text("Scan to register",style: GoogleFonts.poppins(color: Colors.white),),
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
