import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/loginpage/homepage.dart';
import 'package:flutter_application_1/loginpage/loginpage.dart';

class authgate extends StatelessWidget {
  const authgate({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: StreamBuilder<User?>(stream: 
      FirebaseAuth.instance.authStateChanges(), 
      builder: (context, snapshot){
        if(snapshot.hasData){
          return  Homepage();
        }
        else{
          return  loginPage();
        }
      }),

    );
  }
}