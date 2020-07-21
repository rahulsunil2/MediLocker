import 'dart:convert';

import 'package:http/http.dart' as http;

import '../global.dart';

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
    print('Response:${response.body}');
    return (json.decode(response.body)['data'].toList());
  });
    //String url = Common.baseURL + 'check_avail?search=$query';
    //final response = await http.get(Uri.encodeFull(url));
    //List<dynamic> data= jsonDecode(response.body);
    //return (data);

  }
}

