import 'package:http/http.dart' as http;

class SigninService {
  static Future<bool> signin(String email, String passwd) async {
    final url = Uri.parse(
        'http://ec2-15-164-159-42.ap-northeast-2.compute.amazonaws.com:8082/auth/signin/password?email=$email&password=$passwd');
    var headers = {
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.post(url, headers: headers);
      print('----------sign in----------');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      // 상태 코드 200번대는 보통 성공을 의미합니다.
      if (response.statusCode >= 200 && response.statusCode < 300) {
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
