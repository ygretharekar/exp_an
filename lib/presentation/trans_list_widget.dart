import 'package:flutter/material.dart';
import 'package:exp_an/models/models.dart';

class TransListWidget extends StatelessWidget {

  final List<Transaction> list;

  TransListWidget(this.list);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, i) {
          String cat = list[i].category.toString();
          return new  ListTile(
            leading: new Text(
                list[i].cost.toString(),
                textScaleFactor: 1.3,
            ),
            title: new Text(
              cat.split('.')[1].toUpperCase()
            ),
            subtitle: new Text(list[i].description),
          );
        },
      )
    );
  }
}
