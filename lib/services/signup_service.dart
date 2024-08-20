import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignupService {
  //회원가입 시 사용자가 아이디와 비밀번호를 입력했을 때 실행
  static signup(String email, String passwd) async {
    final url = Uri.parse(
        'http://ec2-15-164-159-42.ap-northeast-2.compute.amazonaws.com:8082/auth/signup');
    var data = {
      'userEmail': email,
      'password': passwd,
    };
    var body = jsonEncode(data);
    var headers = {
      'Content-Type': 'application/json',
    };
    final response = await http.post(url, headers: headers, body: body);
    print('----------sign up----------');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  static Future<bool> checkName(String name) async {
    final url = Uri.parse(
        'http://ec2-15-164-159-42.ap-northeast-2.compute.amazonaws.com:8082/auth/check/nickname?userNickname=$name');
    var headers = {
      'Content-Type': 'application/json',
    };
    try {
      final response = await http.get(url, headers: headers);
      print('----------check name----------');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        bool isNicknameOK = responseData['isNicknameOK'];
        return isNicknameOK ? true : false;
      } else {
        return false;
      }
    } catch (e) {
      print('Error during check name: $e');
      return false;
    }
  }

  static signupDetails(
      String name, int age, String sex, String job, String mbti) async {
    final url = Uri.parse(
        'http://ec2-15-164-159-42.ap-northeast-2.compute.amazonaws.com:8082/auth/signup/details');
    var data = {
      'userNickname': name,
      'userAge': age,
      'userSexuality': sex,
      'userMbti': mbti,
      'userJob': job,
    };
    var body = jsonEncode(data);
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');
    print('*****token: $token*****');
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    final response = await http.post(url, headers: headers, body: body);
    print('----------sign up details----------');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}
