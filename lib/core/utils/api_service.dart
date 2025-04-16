import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService({required this.dio});

  Future<List<dynamic>> getPots({required String endpoint}) async {
    var response = await dio.get(endpoint);
    return response.data;
  }
}
