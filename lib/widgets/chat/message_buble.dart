import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble( this.message, this.username,this.userImage, this.isMe );
  // final  Key ? key;
  final String message;
  final String username;
  final String userImage;
  final bool isMe;



  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        Row(
          mainAxisAlignment: isMe ? MainAxisAlignment.end :MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isMe ? Colors.grey[300] :Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                  bottomLeft: ! isMe ? Radius.circular(0):Radius.circular(14),
                  bottomRight: isMe ? Radius.circular(0):Radius.circular(14),
                ),
              ),
              width: 140,
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 16,horizontal: 8),
              child: Column(
                crossAxisAlignment: isMe ? CrossAxisAlignment.end:CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isMe ? Colors.black :
                      Colors.white70 ,
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isMe ? Colors.black :
                      Colors.white70 ,
                    ),
                    textAlign: isMe ? TextAlign.end: TextAlign.start,
                  ),
                ],
              ),
            )
          ],
        ),
        Positioned(
          top: 0, left:isMe ?null:120,
            right: !isMe ?null:120,
            child: CircleAvatar(
              backgroundImage: NetworkImage(userImage),
            )
        ),
      ],
      overflow: Overflow.visible,
    );
  }
}
