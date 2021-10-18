import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:chattinghassan/widgets/authform.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthScreen extends StatefulWidget {

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoading=false;
  void _sumbiuter(String email,String password,String username,File image,bool isLogin,BuildContext ctx)async{
    UserCredential authResult;
    try {
      if (mounted) {
        setState(() {
         _isLoading=true;
        });
      }
        authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password
        );
        final rfs=  FirebaseStorage.instance.ref().child('user_image').child(authResult.user!.uid + '.jpg');
       await rfs.putFile(image);
       final url=await rfs.getDownloadURL();
       FirebaseFirestore.instance.collection('users').doc(authResult.user!.uid)
        .set({
          'username':username,
          'password':password,
         'image_url':url,
         'userId':authResult.user!.uid,
        });
    }
    on FirebaseAuthException catch (e) {
      String message="";
      if (e.code == 'weak-password') {
        message=('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
       message= ('The account already exists for that email.');
      }
      else if (e.code == 'user-not-found') {
        message=('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        message=('Wrong password provided for that user.');
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),backgroundColor: Colors.red,));

      if (mounted) {
        setState(() {
          _isLoading=false;
        });
      }
    } catch (e) {
      print(e);
      if (mounted) {
        setState(() {
         _isLoading=false;
        });
      }
    }
  }
  void _sumele(String email1,String password1,BuildContext ctx1) async{
    UserCredential authResult;
    try{
      if (mounted) {
        setState(() {
          _isLoading=true;
        });
      }
      authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email1,
          password: password1
      );
    }
    on FirebaseAuthException catch (e) {
      String message="";
      if (e.code == 'weak-password') {
        message=('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        message= ('The account already exists for that email.');
      }
      else if (e.code == 'user-not-found') {
        message=('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        message=('Wrong password provided for that user.');
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),backgroundColor: Colors.red,));


      if (mounted) {
        setState(() {
          _isLoading=false;
        });
      }
    } catch (e) {
      print(e);
      if (mounted) {
        setState(() {
          _isLoading=false;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_sumbiuter,_sumele,_isLoading),
    );
  }
}
