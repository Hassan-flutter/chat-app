import 'dart:io';

import 'package:chattinghassan/widgets/pickers/userpicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
   final void Function(String email,String password,String username,File image,bool isLogin,BuildContext ctx) subuitfn;
   final void Function(String email,String passweord,BuildContext ctx ) sumbx;
   final bool _isLoading;
   AuthForm( this.subuitfn, this.sumbx,this._isLoading);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _fromKey=GlobalKey<FormState>();
  bool _isLogin=true;
  String _email="";
  String _password="";
  String _username="";
  File ? _userImage;
  void _pickImage(File ? pickedImage){
    setState(() {
      _userImage=pickedImage!;
    });
  }
  void _submit(){
    final isValid=_fromKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if(!_isLogin &&_userImage==null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("pick image")));
      return;
    }
    if(_isLogin==true){
     if(isValid){
       _fromKey.currentState!.save();
       widget.sumbx(_email.trim(),_password.trim(),context);
     }
    }

    else {
      if(isValid){
        _fromKey.currentState!.save();
       widget.subuitfn(_email.trim(),_password.trim(),_username.trim(),_userImage!,_isLogin,context);
      }
    }

  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _fromKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if(! _isLogin) UserImagePicker(_pickImage),
                TextFormField(
                  autocorrect: false,
                  enableSuggestions: false,
                  textCapitalization: TextCapitalization.none,
                  key:ValueKey('email') ,
                  validator: ( val){
                    if( val!.isEmpty || !val.contains('@')){
                      return "please enter a valid email adders";
                    }
                    return null;
                  },
                  onSaved: (val)=>_email=val!,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: "Email Adders"),
                ),
                if(!_isLogin)
                  TextFormField(
                    autocorrect: true,
                    enableSuggestions: false,
                    textCapitalization: TextCapitalization.words,
                    key:ValueKey('username') ,
                    validator: (val){
                      if(val!.isEmpty || val.length < 4){
                        return "please enter at least 4 char";
                      }
                      return null;
                    },
                    onSaved: (val)=>_username=val!,
                    decoration: InputDecoration(labelText: "Username"),
                  ),
                TextFormField(
                  key:ValueKey('password') ,
                  validator: (val){
                    if(val!.isEmpty || val.length < 7){
                      return "please enter at least 7 char";
                    }
                    return null;
                  },
                  onSaved: (val)=>_password=val!,
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true,
                ),
                SizedBox(height: 12),
                if(widget._isLoading)
                  CircularProgressIndicator(),
                if(!widget._isLoading)
                ElevatedButton(
                  onPressed: _submit,
                  child: Text(_isLogin ?'Login':'Sign up'),
                ),
                if(!widget._isLoading)
                TextButton(
                    onPressed: (){
                      setState(() {
                        _isLogin=! _isLogin;
                      });
                    },
                    child: Text(_isLogin ?"created new an account":"I already have an account"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
