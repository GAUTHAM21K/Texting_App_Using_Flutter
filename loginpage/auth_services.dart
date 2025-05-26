// ignore_for_file: prefer_const_constructors, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/loginpage/loginpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AuthServices {
  //instance of auth

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  //sign in 
  Future<UserCredential> signinwithemailpass(BuildContext context, email, password) async{

    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
       _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid' : userCredential.user!.uid,
        'email': email,
        'chatttingwith' : [],
        });
      return userCredential;
    }on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }
  }

  //sign up
  Future<UserCredential?> signupwithemailandpass(BuildContext context, String email ,password) async {

    
    try{

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword( email: email, password: password);

      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid' : userCredential.user!.uid,
        'email': email,
        'chatttingwith' : [],

        });


      return userCredential;
    }on FirebaseAuthException catch (e){
      throw Exception(e.code);
    }
  }

  //sign out
  Future<void> signOut() async{
    return await _auth.signOut();
  }

  //error

  //if exiists

  Future<bool> checkEmails(String email) async{
    try{
    QuerySnapshot querySnapshot = await _firestore.collection('users').where('email', isEqualTo : email).get();
    return querySnapshot.docs.isNotEmpty;
    }catch(e){
      print('error already exist');
      return false;
    }
  }

  Future<void> addUser(String userId, String email) async {
  await _firestore.collection('users').doc(userId).set({
    'reciever'
    'email': email,
  });
}

}




