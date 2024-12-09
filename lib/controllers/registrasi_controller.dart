import 'dart:convert';
import 'package:pos_uas/helpers/api.dart';
import 'package:pos_uas/helpers/api_url.dart';
import 'package:pos_uas/model/registrasi.dart';

class RegistrasiController {
  static Future<Registrasi> registrasi(
      {String? nama, String? email, String? password}) async {
    String apiUrl = ApiUrl.registrasi;
    var body = {"nama": nama, "email": email, "password": password};
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return Registrasi.fromJson(jsonObj);
  }
}
