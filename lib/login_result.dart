import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginResult {
  //int success;
  String message;
  String id_user;
  String username;
  String daerah;
  String no_telepon;
  String nama_lengkap;
  

  LoginResult(
      {//this.success,
      this.message,
      this.id_user,
      this.username,
      this.daerah,
      this.no_telepon,
      this.nama_lengkap});

  factory LoginResult.createLoginResult(Map<dynamic, dynamic> object) {
    return LoginResult(
      //success: object['success'],
      message: object['message'],
      id_user: object['id_user'],
      username: object['username'],
      daerah: object['daerah'],
      no_telepon: object['no_telepon'],
      nama_lengkap: object['nama_lengkap'],
    );
  }

  static Future<LoginResult> connectToAPILogin(
      String username, String password) async {
    String apiURL =
        "http://wardes.pasamanbaratkab.go.id/api_android/login_user.php";

    var apiResult = await http
        .post(apiURL, body: {"username": username, "password": password});

    var jsonObject = json.decode(apiResult.body);

    return LoginResult.createLoginResult(jsonObject);
  }
}
