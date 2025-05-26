// ignore_for_file: prefer_const_constructors, unused_import

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/loginpage/auth_gate.dart';
import 'package:flutter_application_1/loginpage/chatpage.dart';
import 'package:flutter_application_1/loginpage/homepage.dart';
import 'package:flutter_application_1/loginpage/loginpage.dart';
import 'package:flutter_application_1/loginpage/settings.dart';
import 'package:flutter_application_1/loginpage/signinpage.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp (const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      home : authgate(),
      routes: {
        '/login': (context) => loginPage(),
        '/signin': (context) => Signinpage(),
        '/homepage' : (context) => Homepage(),
        '/settings' : (context) => settings(),
      },
      );
    }
}





