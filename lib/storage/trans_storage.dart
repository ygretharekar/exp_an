import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:exp_an/models/models.dart';
import 'package:path_provider/path_provider.dart';

class TransStorage {
  Future<Directory> getDirectory() async {
    final directory = await getApplicationDocumentsDirectory();

    return directory;
  }

  const TransStorage();

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
        periodic: json['periodic'] as bool,
        important: json['important'] as bool
    );
  }

  Future<List<Transaction>> loadTrans() async {
    final file = await _getLocalFile();
    final string = await file.readAsString();

    final json = new JsonDecoder().convert(string);

    final trans = (json['transactions'] as List<Map<String, dynamic>>)
                  .map((t) => fromJson(t)).toList();
    return trans;
  }

  Future<File> saveTrans(List<Transaction> trans) async {

    final file = await _getLocalFile();

    return file.writeAsString(
      new JsonEncoder().convert(
        {
          'transactions': trans.map(
            (t) => t.toJson()
          ).toList()
        }
      )
    );
  }

}