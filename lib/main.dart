
import 'package:chattinghassan/screens/auth_screen.dart';
import 'package:chattinghassan/screens/chat_screen.dart';
import 'package:chattinghassan/screens/chathome.dart';
import 'package:chattinghassan/screens/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        canvasColor: Colors.white70,
        backgroundColor: Colors.pink,
        accentColor: Colors.deepPurple,
        accentColorBrightness: Brightness.dark
      ),
      home: StreamBuilder(stream:FirebaseAuth.instance.authStateChanges() ,builder: (ctx,snapShot){
        if(snapShot.connectionState==ConnectionState.waiting){
          return SplashScreen();
        }
        if(snapShot.hasData){
          return ChatHome();
        }
        else{
          return AuthScreen();
        }
      }),
      routes: {
        ChatScreen.routeName:(context)=>ChatScreen()
      },
    );
  }
}


