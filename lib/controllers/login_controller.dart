import 'dart:convert';
import 'package:pos_uas/helpers/api.dart';
import 'package:pos_uas/helpers/api_url.dart';
import 'package:pos_uas/model/login.dart';

class LoginController {
  static Future<Login> login({String? email, String? password}) async {
    String apiUrl = ApiUrl.login;
    var body = {"email": email, "password": password};
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return Login.fromJson(jsonObj);
  }
}
