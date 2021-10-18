
import 'package:chattinghassan/screens/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ChatHome extends StatelessWidget {
  // Future getDocs() async {
  //   var collection = FirebaseFirestore.instance.collection('users');
  //   var querySnapshots = await collection.get();
  //   for (var snapshot in querySnapshots.docs) {
  //     var documentID = snapshot.id;
  //     print(documentID);
  //   }
  // }
 // Widget hass(String nameIt,String imageIt){
 //
 //   return Card(
 //     elevation: 6,
 //     margin: EdgeInsets.all(10),
 //     child: ListTile(
 //       title: Text(nameIt),
 //       leading: CircleAvatar(
 //         backgroundImage: NetworkImage(imageIt),
 //       ),
 //     ),
 //   );
 //  }

  @override
  Widget build(BuildContext context) {
           return Scaffold(
             appBar: AppBar(title: Text("chatting"),
               actions: [
                 DropdownButton(
                   underline: Container(),
                   icon: Icon(Icons.more_vert),
                   items: [
                     DropdownMenuItem(child: Row(children: [
                       Icon(Icons.exit_to_app,color:Colors.red),
                       SizedBox(width: 8),
                       Text('Log out')
                     ]),
                       value: 'logout',
                     )
                   ],
                   onChanged: (itemknow){
                     if(itemknow=='logout'){
                       FirebaseAuth.instance.signOut();
                     }
                   },
                 )
               ],
             ),
            body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (ctx,AsyncSnapshot snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
                return CircularProgressIndicator();
              }
              if(!snapshot.hasData){
                return Center(child: Text("nothing",style: TextStyle(color: Colors.red,fontSize: 30),));
              }
              final  docs = snapshot.data.docs;
              return SafeArea(
                child: ListView.builder(
                    itemCount: docs.length,
                    itemBuilder:(ctx,index){
                      final String hass=docs[index]['userId'];
                      return docs[index]['userId']!=FirebaseAuth.instance.currentUser!.uid?
                      Card(
                        elevation: 6,
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          onTap:()=> Navigator.of(context).pushNamed(ChatScreen.routeName,
                            arguments: {
                            'userIt':hass
                            }
                          ),
                          title: Text(docs[index]['username']),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(docs[index]['image_url']),
                          ),
                        ),
                      ):Container(
                        child: Text(""),
                      );
                    }

                ),
              );
            }),

    );
  }
}

