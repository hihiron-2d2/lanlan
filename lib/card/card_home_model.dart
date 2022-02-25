import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lanlan/domain/card.dart';

class CardListModel extends ChangeNotifier{
  List<FlipCard>? flipCards;

  static final folderRef = FirebaseFirestore.instance.collection('folders');
  static final flipcardRef = FirebaseFirestore.instance.collection('flipcards');

  String? get folderId => null;

  void fetchCardList() async {
    final QuerySnapshot snapshot = await folderRef.doc(folderId).collection('flipcards').get();

    final List<FlipCard>? flipCards = snapshot.docs.map((DocumentSnapshot document) {
      Map<String?, dynamic> data = document.data()! as Map<String?, dynamic>;
      final String? id = document.id;
      final String? frontWord = data['frontWord'];
      final String? backWord = data['backWord'];
      return FlipCard(id, frontWord, backWord);
    }).toList();

    this.flipCards = flipCards;
    notifyListeners();
  }

  // static Future<List<FlipCard>?> getFlipCard(String? foldersId) async {
  //    final flipcardRef = folderRef.doc(foldersId).collection('flipcards');
  //    List<FlipCard> flipcardList = [];
  //    final snapshot = await flipcardRef.get();
  //    await Future.forEach(snapshot.docs, (doc) {
  //      bool isCard;
  //      Future<SharedPreferences> myCard = SharedPreferences.getInstance();
  //      if(doc?.data()['frontWord'] == myCard) {
  //       isCard = true;
  //      } else {
  //       isCard = false;
  //      }
  //      FlipCard flipcard = FlipCard(
  //        flipcard: doc?.data()['flipcards'],
  //        isCard: isCard,
  //        backWord: doc?.data()['backWord'],
  //      );
  //      flipcardList.add(flipcard);
  //    });
  //
  //    return flipcardList;
  // }
}