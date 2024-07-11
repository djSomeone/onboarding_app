

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void toast({required String msg})
{
  Fluttertoast.showToast(msg: msg,backgroundColor: Colors.white,textColor: Colors.black);
}
class Print {
  static void p(String x) {
    debugPrint("======================$x====================");
  }
}

class ConstColor {
  static var primery = Color(0xFF004AAD);
  static var grey = Color(0xFFFDFDFD);
  static var DarkGrey = Color(0xFFD2D2D2);


// static
}

class ButtonController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Print.p("init ButtonController");
  }
  final isLoading = false.obs; // Observable boolean for button state

  void handleClick(dynamic onPressed) async {
    isLoading.value = true; // Show loading state
    await onPressed(); // Execute provided function
    isLoading.value = false; // Reset button state
  }
}
Widget standardButton({
  required String title,
  required dynamic onPressed,
})  {
  final controller = Get.put(ButtonController()); // Get the controller instance

  return Obx(
        () => SizedBox(
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: controller.isLoading.value
              ? Colors.grey
              : ConstColor.primery, // Dynamic color based on state
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: controller.isLoading.value?(){toast(msg: "Loading...");}:() => controller.handleClick(onPressed), // Use controller method
        child: Center(
          child: controller.isLoading.value
              ? SizedBox(height:15,width: 15,child: CircularProgressIndicator(color:ConstColor.DarkGrey,strokeWidth: 2,)) // Show progress indicator
              : Text(
            title,
            style: GoogleFonts.poppins(color: Colors.white,fontSize: 16,),
          ),
        ),
      ),
    ),
  );
}
AppBar standeredAppBar({required String title,bool enableBackButton=false})
{
  return  AppBar(leading:enableBackButton? IconButton(icon:Icon(Icons.arrow_back,color: Colors.white,),
    onPressed: (){Get.back();},
    color: Colors.white,):Text(""),
    title:Text(title,
      style: TextStyle(fontSize: 16,color: Colors.white),),
    centerTitle: true,backgroundColor: ConstColor.primery,

  );
}

String getIdOnly(String path)
{
  Print.p("RegistrationForm");
  String id = path.split("/")[3].toString();
  Print.p(id.toString());
  return id;
}