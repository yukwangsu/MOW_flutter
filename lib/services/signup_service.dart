import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

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

  //중복된 이메일 방지
  static Future<bool> checkEmail(String email) async {
    final url = Uri.parse(
        'http://ec2-15-164-159-42.ap-northeast-2.compute.amazonaws.com:8082/auth/check/email?userEmail=$email');
    var headers = {
      'Content-Type': 'application/json',
    };
    try {
      final response = await http.get(url, headers: headers);
      print('----------check email----------');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        bool isEmailOK = responseData['isEmailOK'];
        return isEmailOK;
      } else {
        print('Error during check email not 200');
        return false;
      }
    } catch (e) {
      print('Error during check email: $e');
      return false;
    }
  }

  //이메일에 인증코드 발송
  static Future<String> sendEmail(String email) async {
    final url = Uri.parse(
        'http://ec2-15-164-159-42.ap-northeast-2.compute.amazonaws.com:8082/auth/send/push/code/email?userEmail=$email');
    var headers = {
      'Content-Type': 'application/json',
    };
    try {
      final response = await http.get(url, headers: headers);
      print('----------send email code----------');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        String message = responseData['message'];
        return message;
      } else {
        return 'error';
      }
    } catch (e) {
      print('Error during check code: $e');
      return 'error';
    }
  }

  //중복된 닉네임 방지
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

  //사용자 정보 입력
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
      'accessToken': '$token',
      'Content-Type': 'application/json',
    };
    final response = await http.post(url, headers: headers, body: body);
    print('----------sign up details----------');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  //구글계정으로 회원가입
  static googleSignup() async {
    final url = Uri.parse(
        'http://ec2-15-164-159-42.ap-northeast-2.compute.amazonaws.com:8082/oauth2/authorization/google');
    var headers = {
      'Content-Type': 'application/json',
    };
    final response = await http.post(url, headers: headers);
    print('----------google sign up----------');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    const String urlString =
        'http://ec2-15-164-159-42.ap-northeast-2.compute.amazonaws.com:8082/oauth2/authorization/google';
    final Uri googleUrl = Uri.parse(Uri.encodeFull(urlString));

    if (await canLaunchUrl(googleUrl)) {
      await launchUrl(googleUrl);
    } else {
      throw 'Could not launch $googleUrl';
    }
  }
}
