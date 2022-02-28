import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lanlan/domain/card.dart';

class CardListModel extends ChangeNotifier{
  List<Flipcard>? flipcards;

  static final folderRef = FirebaseFirestore.instance.collection('folders');

  void fetchCardList(String? id) async {
    final QuerySnapshot snapshot = await folderRef.doc(id).collection('flipcards').get();

    final List<Flipcard>? flipcards = snapshot.docs.map((DocumentSnapshot document) {
      Map<String?, dynamic> data = document.data()! as Map<String?, dynamic>;
      final String? id = document.id;
      final String? frontWord = data['frontWord'];
      final String? backWord = data['backWord'];
      return Flipcard(id, frontWord, backWord);
    }).toList();

    this.flipcards = flipcards;
    notifyListeners();
  }
}

