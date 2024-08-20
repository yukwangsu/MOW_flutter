import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SigninService {
  static Future<bool> signin(String email, String passwd) async {
    final url = Uri.parse(
        'http://ec2-15-164-159-42.ap-northeast-2.compute.amazonaws.com:8082/auth/signin/password?email=$email&password=$passwd');
    // final url = Uri.parse(
    //     "http://10.0.2.2:5000/auth/signin/password?email=123&password=asd");
    var headers = {
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.post(url, headers: headers);
      print('----------sign in----------');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      //accessToken 저장시 에러 발생 -> 해결
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        String accessToken = responseData['accessToken'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', accessToken);
        print('AccessToken saved: $accessToken');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error during sign in: $e');
      return false;
    }
  }
}
