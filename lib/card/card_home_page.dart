import 'package:flutter/material.dart';
import 'package:lanlan/card/card_home_model.dart';
import 'package:lanlan/domain/card.dart';
import 'package:provider/provider.dart';

class CardHomePage extends StatelessWidget {
  const CardHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CardListModel>(
      create: (_) => CardListModel()..fetchCardList(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Card"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Consumer<CardListModel>(builder: (context, model, child) {
              final List<FlipCard>? card = model.flipCards;

              if (card == null) {
                return const CircularProgressIndicator();
              }

              final List<Widget> widgets = card
                  .map(  ///mapで囲んでListTileに変換する
                    (card) => ListTile(
                    title: Text(card.frontWord ?? 'no card'),
                    subtitle: Text(card.backWord ?? 'no card'),
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
      ),
    );
  }
}
