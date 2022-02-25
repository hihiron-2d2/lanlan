import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AddFolderModel extends ChangeNotifier{
  String? title;
  File? imageFile;

  //final picker = ImagePicker();

  Future addFolder() async {
    if(title == null || title == "") {
      throw 'no folder name';
    }

    ///Firestoreの追加
    await FirebaseFirestore.instance.collection('folders').add({
      'title': title,
    });
  }

  // Future pickImage() async {
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //
  //   if (pickedFile != null) {
  //     imageFile = File(pickedFile.path);
  //   }
  // }
}
