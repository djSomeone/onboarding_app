import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onboarding_app/utility/constant.dart';

import '../../api/api.dart';
import 'controller/controller.dart';
import 'module/textFeild.dart';

class RegistrationForm extends StatelessWidget {
  String code = "";
  RegistrationForm({required this.code}) {
    Print.p("RegistrationForm");
    code = code.split("/")[3].toString();
    Print.p(code.toString());
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
                onPressed: () async {
                  Print.p(con.data.value.toString());
                  if (con.data.value["Business Name"] != "" &&
                      con.data.value["First Name"] != "" &&
                      con.data.value["Last Name"] != "" &&
                      con.data.value["Phone Number"] != "" &&
                      con.data.value["Email ID"] != "" &&
                      con.data.value["Review Page URL"] != "") {
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
                      res["message"]=="QR code data saved successfully"?Get.back():null;
                    } catch (x) {
                      toast(msg: "There is some issues");
                    }
                  }
                }),
          ],
        ),
      )),
    );
  }
}
