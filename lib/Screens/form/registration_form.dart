import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onboarding_app/main.dart';
import 'package:onboarding_app/utility/constant.dart';

import '../../api/api.dart';
import '../../modules/popUp_model/successfull_popup.dart';
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
  var placeId = TextEditingController();
  var logo = TextEditingController();




  @override
  Widget build(BuildContext context) {
    var uicon = TextEditingController(text: code);
    this.context=context;

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
                      isReadOnly: true,
                    ),
                    TitledTextFeiled(
                        title: "Business Name",
                        placeHolder: "Enter Business Name",
                        controller: bsName,),
                    TitledTextFeiled(
                      title: "First Name",
                      placeHolder: "Enter First Name",
                      controller: firstName,
                    ),
                    TitledTextFeiled(
                      title: "Last Name",
                      placeHolder: "Enter Last Name",
                      controller: lastName,
                    ),
                    TitledTextFeiled(
                      title: "Phone Number",
                      placeHolder: "Enter Phone Number",
                      controller: phNumber,
                      keyBoardType: TextInputType.number,
                      maxlength: 10,
                    ),
                    TitledTextFeiled(
                      title: "Email ID",
                      placeHolder: "Enter Email ID",
                      controller: email,
                      keyBoardType: TextInputType.emailAddress,
                    ),
                    // uwhef
                    TitledTextFeiled(
                      title: "PlaceID",
                      placeHolder: "Enter PlaceID",
                      controller: placeId,

                      keyBoardType: TextInputType.url,
                    ),
                    TitledTextFeiled(
                      title: "Business Logo",
                      placeHolder: "browse and upload",
                      controller: logo,
                      isReadOnly: true,
                      isImage: true,
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
    // Print.p("palce id value->${placeId.text!=""}");
    if ((bsName.text!= '' &&
        firstName.text!= '') && (lastName.text != '' &&
        phNumber.text != '' &&
        email.text != '' &&
        placeId.text!= ''&&
    logo.text!=""
    )) {
      // Print.p("inif");
    toast(msg:"we are in the if statement");
      try {
        var res = await Api.registerCompany(
            id: code,
            placeId: placeId.text,
            businessName:bsName.text,
            firstName: firstName.text,
            lastName: lastName.text,
            contactNumber: phNumber.text,
            email: email.text,
          img: logo.text
        );

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

}

