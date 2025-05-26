// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_application_1/loginpage/auth_services.dart";

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {


  final TextEditingController _emailControl = TextEditingController();
  final TextEditingController _passContrl = TextEditingController();

  @override
  void dispose(){
    _emailControl.dispose();    
    _passContrl.dispose();
    super.dispose();
  }

  void textField(BuildContext context) async{
    final authServices = AuthServices();
    try{
      await authServices.signinwithemailpass(context,_emailControl.text, _passContrl.text );
      Navigator.pushNamed(context, '/homepage');
        }catch(e){
      showDialog(context: context, builder: (context) => const AlertDialog(
        title: Text("invalid password or email"),
      ) );
    }

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
                      child: Text('Log In',
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
                      labelText: 'Username',
                      labelStyle: TextStyle(color: Colors.white),                
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(25.0)),
                      prefixIcon: Icon(Icons.account_circle, color: Colors.white,),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white),borderRadius: BorderRadius.circular(25.0)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(25.0))
               
                    ),
                    ),
                 
                                  SizedBox(width: 10, height: 30,),
                 
                 
                    TextField(
                      obscureText: true,
                      controller: _passContrl,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(25.0)),
                      prefixIcon: Icon(Icons.key,color:Colors.white,),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white),borderRadius: BorderRadius.circular(25.0)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(25.0))
                      ),),
                 
                                    SizedBox(width: 10, height: 50,),
                 
                 
                    ElevatedButton(onPressed: () =>       textField(context)
                    ,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      minimumSize: Size(400, 60)
                    ),
                    child: Text('Log In')),
                                  SizedBox(width: 10, height: 20,),
                 
                 
                    Row( mainAxisAlignment: MainAxisAlignment.center,
               
                      children: [
                        Text('not registered?', style: TextStyle(
                        color:Colors.white,
                        fontSize: 15,
                        ),),
                        SizedBox(width: 10),
                        GestureDetector(onTap: (){
                          Navigator.pushNamed(context, '/signin') ;
                          },
                          child: 
                          Text('register now', style: TextStyle(
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