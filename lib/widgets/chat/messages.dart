import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_buble.dart';

class Messages extends StatelessWidget {
Messages(this.idIt);
final String idIt;
final user1= FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:FirebaseFirestore.instance
          .collection('chat')
          .doc(idIt+user1!.uid)
          .collection('user_chat').orderBy('createdAt',descending: true)
          .snapshots(),
      builder:(ctx,AsyncSnapshot snapShot){
        if(snapShot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(color: Colors.black,));
        }

        final  docs= snapShot.data.docs;
        return ListView.builder(
          reverse: true,
          itemCount: docs.length,
          itemBuilder:(ctx,index)=> MessageBubble(
            docs[index]['text'],
            docs[index]['username'],
            docs[index]['userImage'],
            docs[index]['userId']==FirebaseAuth.instance.currentUser!.uid,
            // key: ValueKey(docs[index].documentID),
          ),
        );
      },
    );
  }
}
