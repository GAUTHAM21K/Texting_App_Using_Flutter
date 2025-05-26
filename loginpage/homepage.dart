// ignore_for_file: prefer_const_constructors, unused_import, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/loginpage/auth_services.dart';
import 'package:flutter_application_1/loginpage/chat_services.dart';
import 'package:flutter_application_1/loginpage/chatpage.dart';
import 'package:flutter_application_1/loginpage/drawer.dart';
import 'package:flutter_application_1/loginpage/loginpage.dart';
import 'package:flutter_application_1/loginpage/usertile.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final AuthServices _authServices = AuthServices();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final ChatServices _chatServices = ChatServices();

  @override
  Widget build(BuildContext context) {
    

    return  Scaffold(
      drawer: drawer(),
      backgroundColor: Color(0xFF1A1A2E),

      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white70),
        backgroundColor: Colors.red,
        title: Text('Home',style: TextStyle(color: Colors.white70,fontWeight: FontWeight.w600),),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        tooltip: "add user",
        onPressed: (){print('add');},
        child: Icon(Icons.add),
        ),

      body: buildUserList(  ),
    );
  }

  Widget buildUserList(){
    return StreamBuilder(
      stream: _chatServices.getUsersStream(),
      builder: (context, snapshot){
        if(snapshot.hasError){return const Text("error");}//error
        if(snapshot.connectionState == ConnectionState.waiting){return const Text("loading");}//loading
        return ListView(
          children:
            snapshot.data!.map<Widget>((userData) => buildUserListItem(userData,context))
            .toList(),
        );
    });
  }

  Widget buildUserListItem(Map<String, dynamic> userData, BuildContext context){
    if(userData['email'] != _auth.currentUser!.email){
       return usertile(text: userData['email'], onTap: (){
      Navigator.push(context,MaterialPageRoute(builder: (context)=> chatpage(receiverEmail: userData['email'],receiverID: userData['uid'],)) );
    });
    }
    else{return Container();}
   
      
  }
}