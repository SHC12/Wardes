import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wardes/Home.dart';
import 'package:wardes/login_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();


}

class _SplashScreenState extends State<SplashScreen> {
 
  @override
  void initState(){
    super.initState();
    splashscreenStart();
  }
  

  splashscreenStart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('username');   
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => email == null ? LoginPage() : HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            
            new Image.asset('assets/logo.png'),

          
            
        
            
          ],
        ),
      ),
    );
  }
}
