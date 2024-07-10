import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onboarding_app/Screens/form/controller/controller.dart';
import 'package:onboarding_app/utility/constant.dart';

class TitledTextFeiled extends StatelessWidget {
  var title;
  var placeHolder;
  var keyBoardType;
  TextEditingController controller;
  var maxline;
  var maxlength;
  var keyword;
  bool isReadOnly;
  TitledTextFeiled(
      {required this.title,
        required this.placeHolder,
        this.keyBoardType = TextInputType.text,
        required this.controller,
        this.maxline = 1,
        this.maxlength = 50,
        required this.keyword,
      this.isReadOnly=false
      });

  var formController = Get.find<FormController>();
  var _debounce;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              title,
              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
          TextFormField(
            onChanged: _handleTextChanged,
            controller: controller,
            maxLines: maxline,
            maxLength: maxlength,
            keyboardType: keyBoardType,
            readOnly: isReadOnly,
            style: GoogleFonts.poppins(),
            

            decoration: InputDecoration(
              filled: isReadOnly?true:false, // Enables background color
              fillColor: Colors.grey.withOpacity(0.5),
              prefixIcon: isReadOnly?Icon(Icons.lock_outline):null,

                counterText: "",
                hintText: placeHolder,
                hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
            focusedBorder: isReadOnly?OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10)):
            OutlineInputBorder(
                borderSide: BorderSide(color: ConstColor.primery),
                borderRadius: BorderRadius.circular(10)),
            ),

          ),
        ],
      ),
    );
  }

  void _handleTextChanged(String x) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      // Perform your delayed action here with the current text
      formController.addData(keyword,x.toString());
    });
  }
}
