import 'package:flutter/material.dart';
import 'package:lanlan/card/card_add_page.dart';
import 'package:lanlan/card/card_home_model.dart';
import 'package:lanlan/domain/card.dart';
import 'package:provider/provider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:lanlan/main.dart';

// ignore: must_be_immutable
class CardHomePage extends StatelessWidget {
  String? id;
  CardHomePage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CardListModel>(
      create: (_) => CardListModel()..fetchCardList(id),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFFAD5A6),
          title: const Text(
            "My Card",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Consumer<CardListModel>(builder: (context, model, child) {
              final List<Flipcard>? card = model.flipcards;

              card?.forEach((element) {logger.info(element.id); logger.info(element.frontWord); logger.info(element.backWord); });

              if (card == null) {
                return const CircularProgressIndicator();
              }

              final List<Widget> widgets = card
                  .map(  ///mapで囲んでListTileに変換する
                    (card) => Card(
                      elevation: 0.0,
                      margin: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 15.0, bottom: 5.0),
                      color: const Color(0x00000000),
                      child: FlipCard(
                        direction: FlipDirection.HORIZONTAL,
                        speed: 500,
                        onFlipDone: (status) {
                          //print(status);
                        },
                        front: Container(
                          height: 120,
                          width: 100,
                          decoration: const BoxDecoration(
                            color: Color(0xFFDAE9E4),
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(card.frontWord ?? 'no card',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        back: Container(
                          height: 120,
                          width: 100,
                          decoration: const BoxDecoration(
                            color: Color(0xFFDAE9E4),
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(card.backWord ?? 'no card',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                   ),
                 )
                  .toList();
              return ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(25.0),
                children: widgets,
              );
            }),
          ),
        ),
        floatingActionButton: Consumer<CardListModel>(builder: (context, model, child,) {
          return FloatingActionButton(
            onPressed: () async {
              //画面遷移
              final bool? added = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddCardPage(id: id),
                  fullscreenDialog: true,
                ),
              );

              if (added != null && added){
                final snackBar = SnackBar(
                  backgroundColor: Colors.lightGreen,
                  content: const Text('Added your card'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                model.fetchCardList(id);
              }
            },
            tooltip: 'Increment',
            backgroundColor: const Color(0xFFFAD5A6),
            child: const Icon(Icons.add),
          );
         }
        ),
      ),
    );
  }
}


