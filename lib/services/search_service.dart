import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchService {
  static Future<List?> searchPlace(
    String keyword,
    int order,
    String locationType,
    List<String> appliedSearchTags,
  ) async {
    final url = Uri.parse(
        'http://ec2-15-164-159-42.ap-northeast-2.compute.amazonaws.com:8082/workspace?order=$order&page=0&size=20');
    var headers = {
      'Content-Type': 'application/json',
    };
    var data = (locationType.isEmpty || locationType == '모든 공간')
        ? {
            "keyword": keyword,
          }
        : {
            "keyword": keyword,
            "workspaceType": [locationType],
          };
    var body = jsonEncode(data);

    try {
      final response = await http.post(url, headers: headers, body: body);
      print('----------[service] search place----------');
      print('Response status: ${response.statusCode}');
      // 추후에 data로 이동
      print('*** appliedSearchTags: $appliedSearchTags');

      // UTF-8로 응답을 수동 디코딩
      final utf8Body = utf8.decode(response.bodyBytes);
      print('Response body: $utf8Body');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = json.decode(utf8Body);
        List workspaces = responseData['workspaceDtoList'];
        return workspaces;
      } else {
        print('Fail searchPlace');
        return null;
      }
    } catch (e) {
      print('Error during searchPlace: $e');
      return null;
    }
  }
}
