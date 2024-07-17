import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onboarding_app/main.dart';
import 'package:onboarding_app/utility/constant.dart';

import '../../api/api.dart';
import '../../modules/popUp_model/successfull_popup.dart';
import 'controller/controller.dart';
import 'module/textFeild.dart';

class RegistrationForm extends StatelessWidget {
  String code = "";
  var context;
  RegistrationForm({required this.code}) {

  }

  var bsName = TextEditingController();
  var firstName = TextEditingController();
  var lastName = TextEditingController();
  var phNumber = TextEditingController();
  var email = TextEditingController();
  var pageUrl = TextEditingController();
  var con = Get.put(FormController());



  @override
  Widget build(BuildContext context) {
    var uicon = TextEditingController(text: code);
    this.context=context;
    con.addData("Unique ID", code);
    return SafeArea(
        child: Scaffold(
            body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    "Registration Form",
                    style: GoogleFonts.poppins(color: Colors.black, fontSize: 32),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Fill the information Carefully",
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w400),
                  )
                ],
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ListView(
                  children: [
                    TitledTextFeiled(
                      title: "Unique ID",
                      placeHolder: "placeHolder",
                      controller: uicon,
                      keyword: "Unique ID",
                      isReadOnly: true,
                    ),
                    TitledTextFeiled(
                        title: "Business Name",
                        placeHolder: "Enter Business Name",
                        controller: bsName,
                        keyword: "Business Name"),
                    TitledTextFeiled(
                      title: "First Name",
                      placeHolder: "Enter First Name",
                      controller: firstName,
                      keyword: "First Name",
                    ),
                    TitledTextFeiled(
                      title: "Last Name",
                      placeHolder: "Enter Last Name",
                      controller: lastName,
                      keyword: "Last Name",
                    ),
                    TitledTextFeiled(
                      title: "Phone Number",
                      placeHolder: "Enter Phone Number",
                      controller: phNumber,
                      keyword: "Phone Number",
                      keyBoardType: TextInputType.number,
                      maxlength: 10,
                    ),
                    TitledTextFeiled(
                      title: "Email ID (optional)",
                      placeHolder: "Enter Email ID",
                      controller: email,
                      keyword: "Email ID",
                      keyBoardType: TextInputType.emailAddress,
                    ),
                    TitledTextFeiled(
                      title: "Review Page URL",
                      placeHolder: "Enter Review Page URL",
                      controller: pageUrl,
                      keyword: "Review Page URL",
                      keyBoardType: TextInputType.url,
                    ),
                  ],
                ),
              )),
              standardButton(
                  title: "Submit",
                  onPressed: onSubmit),
            ],
          ),
        )),
      );

  }
  void onSubmit() async {
    Print.p(con.data.value.toString());
    if (con.data.value["Business Name"] != null &&
        con.data.value["First Name"] != null &&
        con.data.value["Last Name"] != null &&
        con.data.value["Phone Number"] != null &&
        con.data.value["Email ID"] != null &&
        con.data.value["Review Page URL"] != null) {
      Print.p("inif");
      var x = con.data.value;
      try {
        var res = await Api.registerCompany(
            id: code,
            pageUrl: x["Review Page URL"],
            businessName: x["Business Name"],
            firstName: x["First Name"],
            lastName: x["Last Name"],
            contactNumber: x["Phone Number"],
            email: x["Email ID"]);

        toast(msg: res["message"].toString());

        res["message"]=="QR code data updated successfully"? showDialog(context: context,
            barrierDismissible: false,
            builder: (context){
              return SuccessPopup(onButtonPressed: (){
                Get.offAll(MyHomePage());
              });
            }):null;
      } catch (x) {
        toast(msg: "There is some issues");
      }
    }
    else{
      toast(msg: "Fill all the required feilds");
    }
  }
  Future<bool> _onWillPop(BuildContext context) async {
    // Show confirmation dialog before navigating back
    final shouldPop = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit this screen?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
              Navigator.pop(context, true);
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
    return shouldPop ?? false; // return false by default
  }
}

