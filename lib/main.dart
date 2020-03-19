
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wardes/Home.dart';
import 'package:wardes/login_page.dart';
import 'package:wardes/splash_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('username');   
  
  print(email);
  runApp(
   // MaterialApp(home: email == null ? LoginPage() : HomeScreen()));
    MaterialApp(home: SplashScreen()));
}
