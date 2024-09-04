import 'package:dio/dio.dart';
import 'package:onboarding_app/api/responseStructure.dart';

class Api {
  static var dio = Dio();
  static var endPoint = "https://ambulance-booking-backend.vercel.app/";

  static var registerEndPoint = "user/update-qr-data";
  static var checkRegister = "user/check-qr-data-by-id";

  static Future<Map<String, dynamic>> registerCompany({
    required String id,
    required String img,
    required String placeId,
    required String businessName,
    required String firstName,
    required String lastName,
    required String contactNumber,
    required String email,



  }) async{

    var data = FormData.fromMap({
      "firstName": firstName,
      "lastName": lastName,
      "placeId":placeId,
      "businessName":businessName,
      "contactNumber":contactNumber,
      "email":email,
      "image":await MultipartFile.fromFile(img)

    });

    var finalPath = "$endPoint$registerEndPoint?id=${id}";
    var res = await dio.post(finalPath, data: data);
    return ResponseStructure.toResponseStructure(res);
  }

  static Future<Map<String, dynamic>> checkRegistred({required String id})
  async
  {
    var finalPath = "$endPoint$checkRegister?id=${id}";
    var res = await dio.get(finalPath);
    return ResponseStructure.toResponseStructure(res);
  }

}
