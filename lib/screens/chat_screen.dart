
import 'package:chattinghassan/widgets/chat/messages.dart';
import 'package:chattinghassan/widgets/chat/new_messages.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static const routeName='chat';
  @override
  Widget build(BuildContext context) {
    final String ?  hassan12;
    final routarg12 = ModalRoute
        .of(context)!
        .settings
        .arguments as Map<String, String>;
    hassan12= routarg12['userIt'];
    return Scaffold(
      appBar: AppBar(
        title: Text("chat app"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed:(){
            Navigator.of(context).pop(context);
          } ,
        ) ,

      ),
      body:Container(
        child:Column(
          children: [
            Expanded(child: Messages(hassan12!)),
            NewMessages(hassan12),
          ],
        ) ,
      ),

    );
  }
}

