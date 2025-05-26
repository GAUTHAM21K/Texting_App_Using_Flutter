// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, use_build_context_synchronously, avoid_types_as_parameter_names, no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter/physics.dart";
import "package:flutter_application_1/loginpage/auth_services.dart";

class Signinpage extends StatefulWidget {
   const Signinpage({super.key});

  @override
  State<Signinpage> createState() => _SigninpageState();
}

class _SigninpageState extends State<Signinpage> {
  String email = '';
  String password = '';  
  String con_password = '';
  final TextEditingController _emailControl = TextEditingController();
  final TextEditingController _passContrl = TextEditingController();
  final TextEditingController _conpassContol = TextEditingController();

void textField(BuildContext context) {
  setState(() {
    final _auth = AuthServices();

    if (_passContrl.text == _conpassContol.text && _passContrl.text.isNotEmpty) {
      if (_emailControl.text.isNotEmpty) {
        _auth.signupwithemailandpass(context, _emailControl.text, _passContrl.text).then((userCredential) {
          if (userCredential != null) {
            Navigator.pushNamed(context, '/login');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Successfully signed in')),
            );
          }
        }).catchError((e) {
          print('${e}');
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$e')),
            );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Enter email')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords don\'t match')),
      );
    }
  });
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A2E),
      body:
           SingleChildScrollView(
             child: SafeArea(
               child: Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
               
                   Center(
                      child: Image.asset('assets/images/logo.png',height: 200,width: 200,)
                    ),
               
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Sign Up',
                    style: TextStyle(
                      color:Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      ),),),
                 
                    SizedBox(width: 10, height: 50,),
               
               
                      TextField(
                      controller: _emailControl,
                      style: TextStyle(color: Colors.white), 
                      decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.key,color:Colors.white,),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white),borderRadius: BorderRadius.circular(25.0)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(25.0))
               
                      ),),
               
               
                      SizedBox(width: 10, height: 20,),
               
               
                  
                    TextField(
                      obscureText: true,
                      controller: _passContrl, 
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                      labelText: 'New Password',
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.key,color:Colors.white,),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white),borderRadius: BorderRadius.circular(25.0)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(25.0))
               
                      ),),
               
                      SizedBox(width: 10, height: 20,),
               
               
                    TextField( 
                      obscureText: true,
                      controller: _conpassContol,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.key,color:Colors.white,),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white),borderRadius: BorderRadius.circular(25.0)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(25.0))
               
                      ),),
               
                    
                    SizedBox(width: 10, height: 50,),
                 
                    ElevatedButton(onPressed: () => textField(context)
                    ,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      minimumSize: Size(400, 60)
                      ),child:
                       Text('Sign up',
                       style: TextStyle(fontSize: 20),)),
                       SizedBox(width: 10, height: 20,),
               
                      Row( mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('already registered?', style: TextStyle(
                        color:Colors.white,
                        fontSize: 15,
                        ),),
                        SizedBox(width: 10),
                        GestureDetector(onTap: (){
                          Navigator.pushNamed(context, '/login') ;
                          },
                          child: 
                          Text('login', style: TextStyle(
                          color:Colors.red,
                        
                        fontSize: 15,
                        fontWeight: FontWeight.bold,),))
                      ],
                    )
                 
                 
                 
                  ]),
               ),
             ),
           ),
      );
  }
}