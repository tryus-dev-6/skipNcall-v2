
import 'package:http/http.dart' as http;
import 'Constants.dart';

class BaseClient {

  var client = http.Client();

  Future<dynamic> post(String api, Object data) async {
    var url = Uri.parse(Constants.BASE_URL + api);

    var response = await client.post(url, body: data);
    if (response.statusCode == 200) {
      return response.body;
    } else {
    }
  }



}