import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
class UserImagePicker extends StatefulWidget {
final void Function (File pickedsrc) imagePickFn;

UserImagePicker(this.imagePickFn);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
   File ? _pickerimage;
  final ImagePicker _picker = ImagePicker();
  void _pickImage(ImageSource src) async{
    final XFile? imagex = await _picker.pickImage(source: src,imageQuality: 50,maxWidth: 150);
    if(imagex !=null){
      setState(() {
        _pickerimage=File(imagex.path);
      });
      widget.imagePickFn(_pickerimage!);
    }
    else{
      print("no image selected");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,

          backgroundImage: _pickerimage !=null ?FileImage(_pickerimage!):null,
        ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
                onPressed:()=> _pickImage(ImageSource.camera),
                icon: Icon(Icons.photo_camera_outlined),
                label: Text("Added Image\nfrom Camera",textAlign: TextAlign.center,)
            ),
            TextButton.icon(
                onPressed:()=> _pickImage(ImageSource.gallery),
                icon: Icon(Icons.image_outlined),
                label: Text("Added Image\nfrom Gallery",textAlign: TextAlign.center,)
            ),
          ],
        )
      ],
    );
  }
}
