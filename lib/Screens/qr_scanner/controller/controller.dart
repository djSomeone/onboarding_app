import 'package:get/get.dart';

class QrDataController extends GetxController{
  RxString qrData="Scan a code".obs;
  void setQrData(String newQrData){
    if(newQrData!=qrData.value)
      {
        qrData.value=newQrData;
      }
  }
}