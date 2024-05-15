import 'package:api_login/postdata/model_class.dart';
import 'package:dio/dio.dart';
class ApiService {
  static Future<dynamic> authenticate(String username, String password) async {
    Map<String, dynamic> requestBody = {
      'username': username,
      'password': password,
    };
    try {
      Response response = await Dio().post(
        'https://dummyjson.com/auth/login',
        data: requestBody,
      );
      if (response.statusCode == 200) {
        return ModelClass.fromJson(response.data);
      }
      throw Exception('Failed to authenticate');
    } catch (error) {
      
      throw Exception('Failed to authenticate');
    }
  } 
}