import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchService {
  static Future<String> searchPlace(String keyword) async {
    final url = Uri.parse(
        'http://ec2-15-164-159-42.ap-northeast-2.compute.amazonaws.com:8082/workspace?order=0&page=0&size=20');
    var headers = {
      'Content-Type': 'application/json',
    };
    var data = {
      "keyword": keyword,
      "workspaceType": ["string"],
      "featureYnList": ["string"]
    };
    var body = jsonEncode(data);
    try {
      final response = await http.post(url, headers: headers, body: body);
      print('----------search place----------');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        String workspaceName =
            responseData['workspaceDtoList'][0]['workspaceName'];
        return workspaceName;
      } else {
        print('Fail searchPlace');
        return 'fail';
      }
    } catch (e) {
      print('Error during searchPlace: $e');
      return 'fail';
    }
  }
}
