import 'dart:convert';
import 'dart:io';

import 'package:get/state_manager.dart';
import 'package:http/http.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var loginProcess = false.obs;
  var error = "";

  String? emailValidator(String value) {
    if (value.isEmpty || value.length < 10) {
      return 'Please enter a valid mobile number';
    }
    return null;
  }

  String? passwordValidator(String value) {
    if (value.isEmpty || value.length < 7) {
      return 'Password must be at least 7 characters long.';
    }
    return null;
  }

  // Future<bool> refresh() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String token = prefs.getString("token");

  //   if (token == null) {
  //     return false;
  //   }

  //   bool success = false;
  //   try {
  //     loginProcess(true);
  //     List loginResp = await CQAPI.refreshToken(token: token);
  //     if (loginResp[0] != "") {
  //       //success
  //       final prefs = await SharedPreferences.getInstance();
  //       prefs.setString("token", loginResp[0]);
  //       success = true;
  //     }
  //   } finally {
  //     loginProcess(false);
  //   }
  //   return success;
  // }
  Future<void> fetchData() async {
    const apiUrl = 'http://192.168.1.18:8080/api/provider/view';

    HttpClient client = HttpClient();
    client.autoUncompress = true;

    final HttpClientRequest request = await client.getUrl(Uri.parse(apiUrl));
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    final HttpClientResponse response = await request.close();

    final String content = await response.transform(utf8.decoder).join();
    final List data = json.decode(content);
    print("hgfgghfyhg");
    print(data);
  }

  Future<void> createAlbum(
      {required String email, required String password,required String password1}) async {
    final response = await post(
      Uri.parse('http://192.168.1.18:8080/api/provider/signin'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'mobile': email,
        'password': password,
         'passwords': password1,
      }),
    );
    print(jsonEncode(<String, String>{
       'mobile': email,
        'password': password,
       
    }));
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      // return List.fromJson(jsonDecode(response.body));
      print("wwwww");
      print(response.body);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }
}
