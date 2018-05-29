import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:exp_an/models/models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class TransStorage {

  final double initialCost;

  Future<Directory> getDirectory() async {
    final directory = await getApplicationDocumentsDirectory();

    return directory;
  }

  const TransStorage(this.initialCost);

  Future<File> _getLocalFile() async {
    final dir = await getDirectory();

    return new File('${dir.path}/transactions.json');
  }

  static Transaction fromJson(Map<String, Object> json){
    return new Transaction(
        json['cost'] as double,
        json['description'] as String,
        uuid: json['uuid'] as String,
        dateTime: DateTime.parse(json['dateTime']),
        category: Categories.values.firstWhere(
            (e) => e.toString() == json['category']
        ),
        periodic: (json['periodic'] as String).toLowerCase() == 'true',
        important: (json['important'] as String).toLowerCase() == 'true'
    );
  }

  static ArcData fromJsonArcData(Map<String, Object> json){
    return new ArcData(
        startAngle: json['startAngle'] as double,
        angle: json['angle'] as double,
        color: new Color((json['color'] as int))
    );
  }

  Future<List<Transaction>> loadTrans() async {
    final file = await _getLocalFile();
    final string = await file.readAsString();

    final json = new JsonDecoder().convert(string);

    final trans = (json['transactions'] as List)
                  .map((t) => fromJson(t)).toList();

    return trans;
  }

  Future<List<ArcData>> loadArcList() async {
    final file = await _getLocalFile();
    final string = await file.readAsString();

    final json = new JsonDecoder().convert(string);

//    print('ArcList: ' + json['arclist'].toString());

    final arcs = (json['arclist'] as List)
                  .map((t) => fromJsonArcData(t)).toList();



    return arcs;
  }

  Future<File> saveTrans(List<Transaction> trans) async {

    final file = await _getLocalFile();

    List<Map<String, Object>> list = [
      {
        'startAngle': 0.0,
        'angle': 0.0,
        'color':  Colors.green
      },
      {
        'startAngle': 0.0,
        'angle': 0.0,
        'color':  Colors.black12
      },
      {
        'startAngle': 0.0,
        'angle': 0.0,
        'color':  Colors.amber
      },
      {
        'startAngle': 0.0,
        'angle': 0.0,
        'color':  Colors.pinkAccent
      },
      {
        'startAngle': 0.0,
        'angle': 0.0,
        'color':  Colors.redAccent
      },
      {
        'startAngle': 0.0,
        'angle': 0.0,
        'color':  Colors.brown
      },
      {
        'startAngle': 0.0,
        'angle': 0.0,
        'color':  Colors.blue
      },
      {
        'startAngle': 0.0,
        'angle': 0.0,
        'color':  Colors.deepPurple
      },
      {
        'startAngle': 0.0,
        'angle': 0.0,
        'color':  Colors.orange
      },
      {
        'startAngle': 0.0,
        'angle': 0.0,
        'color':  Colors.cyanAccent
      },
      {
        'startAngle': 0.0,
        'angle': 0.0,
        'color':  Colors.indigo

      },
      {
        'startAngle': 0.0,
        'angle': 0.0,
        'color':  Colors.white24
      },
    ];

    const double startAngle = 2.35619;
    const double endAngle = 7.06858;

    /*double angle = startAngle;
    double nextAngle = 0.0;
    double addAngle = 0.0;

    final List<Map<String, Object>> arcList = <Map<String, Object>>[];

    trans.forEach(
      (t){
          *//*nextAngle = angle;

          addAngle = (t.cost/this.initialCost) * 4.71239;

          angle = angle + addAngle;

          arcList.add(
              new ArcData(
                  startAngle: nextAngle > endAngle ? 0.0:nextAngle,
                  angle: addAngle,
                  color: _getColor(t.category)
              ).toJson()
          );*//*
      }
    );*/

    double prevAngle = startAngle;
    double sa = 0.0;
    double a = 0.0;
    double total = 0.0;

    List<Map<String, num>> ansList = [];

    list.forEach(
        (item){
          sa = prevAngle + a;
          prevAngle = sa;

          total = 0.0;

          trans.forEach(
              (t){
                if(_getColor(t.category) == item['color']) total += t.cost;
              }
          );

          a = (total/initialCost) * 4.71239;

          if(sa + a > endAngle) a = 0.0;

          ansList.add({
            'startAngle': sa,
            'angle': a,
            'color': (item['color'] as Color).value
          });
        }
    );

    return file.writeAsString(
      new JsonEncoder().convert(
        {
          'transactions': trans.toList(),
          'arclist': ansList
        }
      )
    );
  }

  Future<FileSystemEntity> clean() async {
    final file = await _getLocalFile();

    return file.delete();
  }

  Color _getColor(Categories category){

    if(Categories.food == category) return Colors.green;
    else if(Categories.miscellaneous == category) return Colors.black12;
    else if(Categories.bill == category) return Colors.amber;
    else if(Categories.donation == category) return Colors.pinkAccent;
    else if(Categories.entertainment == category) return Colors.redAccent;
    else if(Categories.fee == category) return Colors.brown;
    else if(Categories.grocery == category) return Colors.blue;
    else if(Categories.lend == category) return Colors.deepPurple;
    else if(Categories.service == category) return Colors.orange;
    else if(Categories.ticket == category) return Colors.cyanAccent;
    else if(Categories.transport == category) return Colors.indigo;
    return Colors.white24;
  }
}