import 'package:flutter/material.dart';
import 'package:exp_an/models/models.dart';

class TransListWidget extends StatelessWidget {

  final List<Transaction> list;

  TransListWidget(this.list);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, i) {
          return new  ListTile(
            leading: new Text(list[i].cost.toString()),
            title: new Text(list[i].category.toString()),
            subtitle: new Text(list[i].description),
          );
        }
    );
  }
}
