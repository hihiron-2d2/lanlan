import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AddCardModel extends ChangeNotifier {
  static final folderRef = FirebaseFirestore.instance.collection('folders');

  String? frontWord;
  String? backWord;

  Future addCard(String? id) async {
    if (frontWord == null || frontWord == "") {
      throw 'no word';
    }

    if (backWord == null || backWord!.isEmpty) {
      throw'no word';
    }

    //Firestoreの追加
    await folderRef.doc(id).collection('flipcards').add({
      'frontWord': frontWord,
      'backWord': backWord,
    });
  }
}