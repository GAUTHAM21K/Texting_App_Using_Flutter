import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/loginpage/message.dart';

class ChatServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Stream<List<Map<String,dynamic>>>getUsersStream(){
      return _firestore.collection("users").snapshots().map((Snapshot) {
        return Snapshot.docs.map((doc){
          final user = doc.data();
          return user;
        }).toList();
      });
  }

  //send
  Future<void> sendMessage(String receiverEmail, message) async{
    final String currentUserId = _auth.currentUser!.uid;
    final String? currentUserEmail = _auth.currentUser!.email;
    final Timestamp timestamp = Timestamp.now(); 

    Message newMessage = Message(
      senderID: currentUserId,
      message: message,
      receiverID: receiverEmail,
      senderEmail: currentUserEmail.toString(),
      timestamp: timestamp);

      List<String> ids = [currentUserId, receiverEmail];
  ids.sort();
  String chatRoomID = ids.join('_');

  await _firestore
    .collection('chatroom')
    .doc(chatRoomID)
    .collection('messages')
    .add(newMessage.toMap());
  }


  


  //recieve
  Stream<QuerySnapshot> getMessages(String userID, otherUserID){
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');
    return _firestore.collection('chatroom').doc(chatRoomID).collection('messages').orderBy('timestamp',descending: false).snapshots();
  }

}