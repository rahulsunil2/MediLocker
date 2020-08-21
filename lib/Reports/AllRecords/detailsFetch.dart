import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../global.dart';

class DetailsFetch {
  static Future<List<dynamic>> searchDjangoApi(String query) async {
    Map<String, String> body = {
      'filename': query,
    };
    String url = Common.baseURL + 'users/medicalimage_get';
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
