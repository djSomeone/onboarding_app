import 'package:flutter/material.dart';

class RegistrationForm extends StatelessWidget {
  String code;
   RegistrationForm({required this.code}){
     code=code.split("/")[3].toString();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:  Placeholder(child: Center(child: Text("Registration page:${code}"),),));
  }
}
