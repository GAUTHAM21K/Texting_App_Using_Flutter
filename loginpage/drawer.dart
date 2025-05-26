// ignore_for_file: prefer_const_constructors, unnecessary_import, camel_case_types, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/loginpage/auth_services.dart';

class drawer extends StatefulWidget {
  drawer({super.key});

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFF1A1A2E),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SafeArea(
                child: Center(
                  child: Image.asset('assets/images/logo.png',height: 200,width: 200,)
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:25,top: 10),
                child: ListTile(
                  title: Text("H O M E",style: TextStyle(color: Colors.white,fontSize: 15),),
                  leading: Icon(Icons.home,size: 30,color: Colors.red,),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:25),
                child: ListTile(
                  title: Text("S E T T I N G S",style: TextStyle(color: Colors.white,fontSize: 15),),
                  leading: Icon(Icons.settings,size: 30,color: Colors.red,),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
            padding: const EdgeInsets.only(left:25,bottom:25),
            child: ListTile(
              title: Text("L O G O U T",style: TextStyle(color: Colors.white,fontSize: 15),),
              leading: Icon(Icons.logout,size: 25,color:Colors.red,),
              onTap: (){

                _auth.signOut();
                Navigator.pop(context);
                Navigator.pushNamed(context, '/login');
              },
            ),
          )
            ],
          )


        ],
      ),
      )
    ;
  }
}