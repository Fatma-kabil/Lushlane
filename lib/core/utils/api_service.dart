import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService({required this.dio});

  Future<List<dynamic>> getPots({required String endpoint}) async {
    var response = await dio.get(endpoint);
    return response.data;
  }



   Future<Response> post(
       {required body,
       required String url,
       required String token,
       Map<String,String>?headers,
       String? contentType}) async {
     var response = dio.post(url,
         data: body,
         options: Options(
             contentType: contentType,
             headers:headers?? {'Authorization': "Bearer $token"}));
     return response;
   }
 
}
