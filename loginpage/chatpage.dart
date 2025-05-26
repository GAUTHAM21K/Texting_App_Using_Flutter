// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/loginpage/auth_services.dart';
import 'package:flutter_application_1/loginpage/chat_services.dart';

class chatpage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID; 
  chatpage({super.key,required this.receiverEmail,required this.receiverID} );

  @override
  State<chatpage> createState() => _chatpageState();
  }

class _chatpageState extends State<chatpage> {
  final TextEditingController _textEditingController = TextEditingController();

  final ChatServices _chatServices = ChatServices();

  final AuthServices _authServices = AuthServices();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // final FocusNode _focusNode = FocusNode();

 
 @override
  void initState() {
    // TODO: implement initState
  
  }
  

  void sendMessage() async{
    if(_textEditingController.text.isNotEmpty){
      await _chatServices.sendMessage(widget.receiverID, _textEditingController.text);
      _textEditingController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xff1a1a2e),
      appBar: AppBar(
        backgroundColor: Colors.red,
        
        title: Text(widget.receiverEmail),
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList(),),
          _userInput()
        ],
      ),
    );
  }

  Widget _buildMessageList(){
    String senderID = _auth.currentUser!.uid;
    return StreamBuilder(
      stream: _chatServices.getMessages(widget.receiverID,senderID),
      builder: (context, snapshot){
        if(snapshot.hasError){return const Text("error");}//error
        if(snapshot.connectionState == ConnectionState.waiting){return const Text("loading");}//loading
          return ListView(
            children:
              snapshot.data!.docs.map((doc) => buildMessageItem(doc))
              .toList(),
          );
        
    });
  }

  Widget buildMessageItem(DocumentSnapshot doc){



   Map<String,dynamic> data = doc.data() as Map<String , dynamic>;
    bool isCurrentUser = data['senderID'] == _auth.currentUser?.uid;
    var currentUser = isCurrentUser  ;

   return Padding(
     padding: const EdgeInsets.all(10.0),
     
     child: Align(
      alignment: currentUser?Alignment.centerRight : Alignment.centerLeft,
       child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: currentUser? Colors.red : Color.fromARGB(255, 70, 70, 101),
        ),

        
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
        child: 
        Text(data["message"],style: TextStyle(color: Colors.white),),
        
       ),
     )
     );
     
   
      
  }

  Widget _userInput(){
    return Row(
      children: [
        Expanded(child: 
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0,left: 10),
            child: TextField(
              controller: _textEditingController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(      
              hintText: '  type....',        
              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(25.0)),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(25.0)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white),borderRadius: BorderRadius.circular(25.0)),               
              ),
            ),
          ),
        ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: IconButton(onPressed: sendMessage, icon: const Icon(Icons.send_outlined,color: Colors.red,),),
          )          
      ],
    );
  }

  
}