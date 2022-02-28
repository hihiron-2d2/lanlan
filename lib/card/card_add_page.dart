import 'package:flutter/material.dart';
import 'package:lanlan/card/card_add_model.dart';
import 'package:provider/provider.dart';


class AddCardPage extends StatelessWidget {
  final String? id;
  const AddCardPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddCardModel>(
      create: (_) => AddCardModel(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: AppBar(
            backgroundColor: const Color(0xFFFAD5A6),
            title: Container(
                margin: const EdgeInsets.only(top:20, left:20),
                child: const Text(
                    "book list sample",
                      style: TextStyle(
                        fontSize: 25,
                   ),
                )),
          ),
        ),
        body: Center(
          child: Consumer<AddCardModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Front word',
                    ),
                    onChanged: (text) {
                      //todo　取得したtextを使う
                      model.frontWord = text;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Back word',
                    ),
                    onChanged: (text) {
                      //todo　取得したtextを使う
                      model.backWord = text;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(onPressed: () async {
                    //追加の処理
                    try {
                      await model.addCard(id);
                      Navigator.of(context).pop(true);
                    } catch (e){
                      final snackBar = SnackBar(
                        backgroundColor: Colors.amber,
                        content: Text(e.toString()),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }, child: const Text('Add'),
                       style: ElevatedButton.styleFrom(
                        primary: const Color(0xFFFAD5A6), //ボタンの背景色
                     ),
                  ),
                ],),
            );
          }),
        ),
      ),
    );
  }
}