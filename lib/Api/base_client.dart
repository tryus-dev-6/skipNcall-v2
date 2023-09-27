import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:skip_n_call/Helper/SharedPreferencesHelper.dart';
import '../Util/Constants.dart';
import 'Constants.dart';

class BaseClient {
  var client = http.Client();

  Future<dynamic> post(String api, Object data) async {
    var url = Uri.parse(Constants.BASE_URL + api);

    var response = await client.post(url, body: data);
    if (response.statusCode == 200) {
      return response.body;
    } else {}
  }

  Future<dynamic> postWithToken(String api, Object data) async {
    var url = Uri.parse(Constants.BASE_URL + api);

    String? token = await SharedPreferencesHelper.getData(SKIP_N_CALL_USER_ACCESS_TOKEN);

    debugPrint('Access_token: $token');

    var response = await client.post(url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: data);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      debugPrint('Error Status Code: ${response.statusCode}');
      debugPrint('Error Response Body: ${response.body}');
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  Future<dynamic> postWithTokenImage(String api, Map data, File? selectedImage, String attribute) async {
    var url = Uri.parse(Constants.BASE_URL + api);

    String? token = await SharedPreferencesHelper.getData(SKIP_N_CALL_USER_ACCESS_TOKEN);

    debugPrint('Access_token: $token');

    var request = http.MultipartRequest('POST', url);

    request.headers['Authorization'] = 'Bearer $token';

    if(selectedImage!=null) {
      request.files.add(await http.MultipartFile.fromPath(attribute, selectedImage!.path));
    }

    data.forEach((key, value) {
      request.fields[key] = value;
    });

    var response = await request.send();

    return response;
  }
}
