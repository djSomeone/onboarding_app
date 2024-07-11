import 'package:get/get.dart';
import 'package:onboarding_app/api/api.dart';

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
    if(qrData.value.length==24){
      try {
        var res = await Api.checkRegistred(id: qrData.value);
        if (res["isRegistered"] == false) {
          Get.back();
          Get.off(RegistrationForm(
            code: qrData.value,
          ));
          // isLoading.value=false;
        } else {
          isRegistered.value = true;
        }
      } catch (x) {
        Print.p("Some thing went wrong");
      }
    }else{
      notScanStarCode.value=true;
    }
  }
}