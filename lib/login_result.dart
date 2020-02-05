import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginResult {
  //int success;
  String message;
  String id_instansi;
  String nama_instansi;
  String id_jenjang_jabatan;
  String id_groups;
  String id_kategori;
  String id_user;
  String username;
  String username_admin;
  String nama_lengkap;

  LoginResult(
      {//this.success,
      this.message,
      this.id_instansi,
      this.nama_instansi,
      this.id_jenjang_jabatan,
      this.id_groups,
      this.id_kategori,
      this.id_user,
      this.username,
      this.username_admin,
      this.nama_lengkap});

  factory LoginResult.createLoginResult(Map<dynamic, dynamic> object) {
    return LoginResult(
      //success: object['success'],
      message: object['message'],
      id_instansi: object['id_instansi'],
      nama_instansi: object['nama_instansi'],
      id_jenjang_jabatan: object['id_jenjang_jabatan'],
      id_groups: object['id_groups'],
      id_kategori: object['id_kategori'],
      id_user: object['id_user'],
      username: object['username'],
      username_admin: object['username_admin'],
      nama_lengkap: object['nama_lengkap'],
    );
  }

  static Future<LoginResult> connectToAPILogin(
      String username, String password) async {
    String apiURL =
        "http://simpel.pasamanbaratkab.go.id/api_android/simaya/model_login.php";

    var apiResult = await http
        .post(apiURL, body: {"username": username, "password": password});

    var jsonObject = json.decode(apiResult.body);

    return LoginResult.createLoginResult(jsonObject);
  }
}
