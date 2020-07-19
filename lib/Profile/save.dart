import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String> uploadToDb(String url, {Map body}) async {
  return http.post(url, body: body).then((http.Response response) {
    print("Response Status: ${response.statusCode}");
    print("Response Body: ${response.body}");

    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return (json.decode(response.body));
  });
}
