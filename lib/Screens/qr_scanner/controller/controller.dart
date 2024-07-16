import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboarding_app/api/api.dart';

import '../../../main.dart';
import '../../../utility/constant.dart';
import '../../form/registration_form.dart';

class QrDataController extends GetxController{
  RxString qrData="Scan a code".obs;
  RxBool isRegistered = false.obs;
  RxBool notScanStarCode=false.obs;
  void setQrData(String newQrData){
    if(newQrData!=qrData.value)
      {
        qrData.value=newQrData;
      }
  }
  void setRegistered() async {
    Print.p((qrData.value.length).toString());
    if(qrData.value.length==24){

      try {
        var res = await Api.checkRegistred(id: qrData.value);
        if (res["isRegistered"] == false) {
          Get.back();
          Get.off(RegistrationForm(
            code: qrData.value,
          ));
        } else {
          isRegistered.value = true;
        }
      } catch (x) {
        Print.p("Some thing went wrong");
        Get.back();
        Get.offAll(MyHomePage());

      }
    }else{
      Print.p("in else");
     setInvailidFlag(true);
      // Get.back();
      // Get.offAll(MyHomePage());
    }
  }
  void setInvailidFlag(bool newValue){
    notScanStarCode.value=newValue;
  }
}