import 'package:get/get.dart';

import '../../../utility/constant.dart';

class FormController extends GetxController
{
  RxMap data=RxMap({"Email ID":"xyz@gmail.com"});

  void addData(String key,String value)
  {
    var lastMap=data.value;
    lastMap.addIf(true, key, value);
    data.value=lastMap;
    Print.p("After updating data");
    Print.p(data.value.toString());
  }
}