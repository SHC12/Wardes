import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wardes/Home.dart';
import 'package:wardes/login_result.dart';
import 'package:http/http.dart' as http;

class Daftar extends StatefulWidget {
  @override
  _DaftarState createState() => _DaftarState();
}

class _DaftarState extends State<Daftar> {
  bool _isSelected = false;

  bool _isLoading = false;
/*
  TextEditingController c_nama_lengkap = TextEditingController();
  TextEditingController c_username = TextEditingController();
  
  TextEditingController c_re_kata_sandi = TextEditingController();
  TextEditingController c_daerah = TextEditingController();
  TextEditingController c_no_telepon = TextEditingController();
*/
TextEditingController c_kata_sandi = TextEditingController();

  String s_nama_lengkap,
      s_username,
      s_password,
      s_re_password,
      s_daerah,
      s_no_telepon;

  final _key = GlobalKey<FormState>();

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      signup();
           

    }
  }

  signup() async {
    Map data = {
      'nama_lengkap': s_nama_lengkap,
      'username': s_username,
      'password': s_password,
      'daerah': s_daerah,
      'no_telepon': s_no_telepon
    };
    var jsonResponse = null;
    var response = await http.post(
        "http://wardes.pasamanbaratkab.go.id/api_android/register_user.php",
        body: data);

    jsonResponse = json.decode(response.body);
  
      if (jsonResponse != null) {
        int code_status = jsonResponse['status'];
        String code_message = jsonResponse['message'];

        print("$code_status.$code_message");

        if (code_status == 1) {
            setState(() {
              Fluttertoast.showToast(
        msg: "Berhasil, silahkan login",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0
    );
              Navigator.pop(context);
            });
        }else if(code_status == 2){
          setState(() {
                Fluttertoast.showToast(
        msg: "Username telah digunakan, silahkan ubah kembali",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0
    );
          });
          print(code_message);
        }else{
          print(code_message);
        }
      }
    
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
      body: Form(
        key: _key,
        child: Stack(
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
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
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
                                fontSize: ScreenUtil.getInstance().setSp(46),
                                letterSpacing: .6,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(80),
                    ),
                    //FormCard(),
                    Container(
                      width: double.infinity,
                      height: ScreenUtil.getInstance().setHeight(1100),
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
                        padding:
                            EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Daftar",
                                style: TextStyle(
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(35),
                                    fontFamily: "Poppins-Bold",
                                    letterSpacing: .6)),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(20),
                            ),
                            Flexible(
                              flex: 1,
                              child: Text("Nama Lengkap",
                                  style: TextStyle(
                                      fontFamily: "Poppins-Medium",
                                      fontSize:
                                          ScreenUtil.getInstance().setSp(26))),
                            ),
                            Flexible(
                              flex: 1,
                              child: TextFormField(
                                validator: (e) {
                                  if (e.isEmpty) {
                                    return "Silahkan isi nama lengkap";
                                  }
                                },
                                onSaved: (e) => s_nama_lengkap = e,
                                decoration: InputDecoration(
                                    hintText: "Masukkan Nama Lengkap",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 12.0)),
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(20),
                            ),
                            Flexible(
                              flex: 1,
                              child: Text("Username",
                                  style: TextStyle(
                                      fontFamily: "Poppins-Medium",
                                      fontSize:
                                          ScreenUtil.getInstance().setSp(26))),
                            ),
                            Flexible(
                              flex: 1,
                              child: TextFormField(
                                validator: (e) {
                                  if (e.isEmpty) {
                                    return "Silahkan isi username";
                                  }
                                },
                                onSaved: (e) => s_username = e,
                                decoration: InputDecoration(
                                    hintText: "Masukkan Username",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 12.0)),
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(20),
                            ),
                            Flexible(
                              flex: 1,
                              child: Text("Kata Sandi",
                                  style: TextStyle(
                                      fontFamily: "Poppins-Medium",
                                      fontSize:
                                          ScreenUtil.getInstance().setSp(26))),
                            ),
                            Flexible(
                              flex: 1,
                              child: TextFormField(
                                validator: (e) {
                                  if (e.isEmpty) {
                                    return "Silahkan isi kata sandi";
                                  }
                                },
                            //    onSaved: (e) => s_password = e,
                            controller: c_kata_sandi,
                                obscureText: true,
                                decoration: InputDecoration(
                                    hintText: "Masukkan Kata Sandi",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 12.0)),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: TextFormField(
                                validator: (e) {
                                  if (e != c_kata_sandi.text) {
                                    return "Kata sandi tidak sama dengan kata sandi diatas";
                                  }else{
                                    return null;
                                  }
                                },
                                onSaved: (e) => s_password = e,
                                obscureText: true,
                                decoration: InputDecoration(
                                    hintText: "Ulangi Kata Sandi",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 12.0)),
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(25),
                            ),
                            Flexible(
                              flex: 1,
                              child: Text("Daerah",
                                  style: TextStyle(
                                      fontFamily: "Poppins-Medium",
                                      fontSize:
                                          ScreenUtil.getInstance().setSp(26))),
                            ),
                            Flexible(
                              flex: 1,
                              child: TextFormField(
                                 validator: (e) {
                                  if (e.isEmpty) {
                                    return "Silahkan isi daerah atau instansi";
                                  }
                                },
                                onSaved: (e) => s_daerah = e,
                                decoration: InputDecoration(
                                    hintText: "Masukkan Daerah",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 12.0)),
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(20),
                            ),
                            Flexible(
                              flex: 1,
                              child: Text("No Telepon",
                                  style: TextStyle(
                                      fontFamily: "Poppins-Medium",
                                      fontSize:
                                          ScreenUtil.getInstance().setSp(26))),
                                          
                            ),
                            Flexible(
                              flex: 1,
                                                          child: TextFormField(
                                                             validator: (e) {
                                  if (e.isEmpty) {
                                    return "Silahkan isi nomor telepon";
                                  }
                                },
                                onSaved: (e) => s_no_telepon = e,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                    hintText:
                                        "Masukkan Nomor yang Dapat Dihubungi",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 12.0)),
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(20),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenUtil.getInstance().setHeight(30)),
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
                        Flexible(
                          flex: 1,
                          child: InkWell(
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
                                    
                                    check();
                                  },
                                  child: Center(
                                    child: Text("DAFTAR",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins-Bold",
                                            fontSize: 18,
                                            letterSpacing: 1.0)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
