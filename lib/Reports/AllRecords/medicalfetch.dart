import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../global.dart';

class MedicalFetch {
  static Future<List<dynamic>> searchDjangoApi(String query) async {
    Map<String, String> body = {
      'category': query,
      'type': 'Report',
      'user': CurrentUser.currentUser
    };
    String url = Common.baseURL + 'users/medicaldata_get';
    return http.post(url, body: body).then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        print(response.statusCode);
        throw new Exception("Error while fetching data");
      }
      print('Response:${json.decode(response.body)['data']}');
      return (json.decode(response.body)['data'].toList());
    });
  }
}
