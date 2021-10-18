

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
   NewMessages(this.st) ;
   final String st ;

  @override
  _NewMessagesState createState() => _NewMessagesState();
}


class _NewMessagesState extends State<NewMessages> {
  final _controller=TextEditingController();
  String _enteredMessage="";

  _sendMessages() async{
    FocusScope.of(context).unfocus();
    final user= FirebaseAuth.instance.currentUser;
    final userDate=await  FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
    FirebaseFirestore
        .instance
        .collection('chat')
        .doc(widget.st+user.uid)
        .collection(
        "user_chat")
        .add({
      'text':_enteredMessage,
      'createdAt':Timestamp.now(),
      'username':userDate['username'] ,
      'userId':user.uid,
      'userImage':userDate['image_url']

    });
    _controller.clear();
    setState(() {
      _enteredMessage="";
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              autocorrect: true,
              enableSuggestions: true,
              textCapitalization: TextCapitalization.sentences,
            controller: _controller,
            decoration: InputDecoration(labelText: 'send a message...'),
            onChanged: (val){
              setState(() {
                _enteredMessage=val;
              });
            },
          ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
              icon: Icon(Icons.send),
              onPressed: _enteredMessage.trim().isEmpty ?null:_sendMessages,
          ),
        ],
      ),
    );
  }
}
