import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wardes/Home.dart';
import 'package:wardes/login_result.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  bool _isSelected = false;

  bool _isLoading = false;

  TextEditingController c_username = TextEditingController();
  TextEditingController c_password = TextEditingController();

  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2.0, color: Colors.black)),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              )
            : Container(),
      );

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  signIn(String username, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'username': username, 'password': password};
    var jsonResponse = null;
    var response = await http.post(
        "http://simpel.pasamanbaratkab.go.id/api_android/simaya/model_login.php",
        body: data);

    jsonResponse = json.decode(response.body);

    setState(() {
      _isLoading = false;

      if (jsonResponse != null) {
      int success = jsonResponse['success'];

      
      if (success == 1) {
        sharedPreferences.setString("message", jsonResponse['message']);
        sharedPreferences.setString("username", jsonResponse['username']);
        sharedPreferences.setString("id_instansi", jsonResponse['id_instansi']);
        sharedPreferences.setString(
            "nama_instansi", jsonResponse['nama_instansi']);
        sharedPreferences.setString(
            "id_jenjang_jabatan", jsonResponse['id_jenjang_jabatan']);
        sharedPreferences.setString("id_groups", jsonResponse['id_groups']);
        sharedPreferences.setString("id_kategori", jsonResponse['id_kategori']);
        sharedPreferences.setString("id_user", jsonResponse['id_user']);
        sharedPreferences.setString(
            "username_admin", jsonResponse['username_admin']);
        sharedPreferences.setString(
            "nama_lengkap", jsonResponse['nama_lengkap']);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
            (Route<dynamic> route) => false);
      }
    } else {
      print(response.body);
      
    }
    });
    
  }

  @override
  Widget build(BuildContext context) {
    LoginResult loginResult = null;

    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: Container(),
                    ),
                    Image.asset("assets/image_02.png")
                  ],
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Image.asset(
                              "assets/logo.png",
                              width: ScreenUtil.getInstance().setWidth(110),
                              height: ScreenUtil.getInstance().setHeight(110),
                            ),
                            Text("Wartawan Desa",
                                style: TextStyle(
                                    fontFamily: "Poppins-Bold",
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(46),
                                    letterSpacing: .6,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(180),
                        ),
                        //FormCard(),
                        Container(
                          width: double.infinity,
                          height: ScreenUtil.getInstance().setHeight(500),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0.0, 15.0),
                                    blurRadius: 15.0),
                                BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0.0, -10.0),
                                    blurRadius: 10.0),
                              ]),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Login",
                                    style: TextStyle(
                                        fontSize:
                                            ScreenUtil.getInstance().setSp(45),
                                        fontFamily: "Poppins-Bold",
                                        letterSpacing: .6)),
                                SizedBox(
                                  height:
                                      ScreenUtil.getInstance().setHeight(30),
                                ),
                                Text("Username",
                                    style: TextStyle(
                                        fontFamily: "Poppins-Medium",
                                        fontSize: ScreenUtil.getInstance()
                                            .setSp(26))),
                                TextFormField(
                                  controller: c_username,
                                  decoration: InputDecoration(
                                      hintText: "Masukkan Username",
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 12.0)),
                                ),
                                SizedBox(
                                  height:
                                      ScreenUtil.getInstance().setHeight(30),
                                ),
                                Text("Kata Sandi",
                                    style: TextStyle(
                                        fontFamily: "Poppins-Medium",
                                        fontSize: ScreenUtil.getInstance()
                                            .setSp(26))),
                                TextFormField(
                                  controller: c_password,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: "Masukkan Kata Sandi",
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 12.0)),
                                ),
                                SizedBox(
                                  height:
                                      ScreenUtil.getInstance().setHeight(35),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                            height: ScreenUtil.getInstance().setHeight(40)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 12.0,
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                              ],
                            ),
                            InkWell(
                              child: Container(
                                width: ScreenUtil.getInstance().setWidth(330),
                                height: ScreenUtil.getInstance().setHeight(100),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Color(0xFF17ead9),
                                      Color(0xFF6078ea)
                                    ]),
                                    borderRadius: BorderRadius.circular(6.0),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color(0xFF6078ea).withOpacity(.3),
                                          offset: Offset(0.0, 8.0),
                                          blurRadius: 8.0)
                                    ]),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      /*Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return HomePage();
                                }));*/
                                setState(() {
                                  _isLoading = true;
                                });

                                      signIn(c_username.text, c_password.text);
                                    },
                                    child: Center(
                                      child: Text("MASUK",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Poppins-Bold",
                                              fontSize: 18,
                                              letterSpacing: 1.0)),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
