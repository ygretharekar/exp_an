import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class CounterStorage {

  const CounterStorage();

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
//    print(path);
    return new File('$path/counter.txt');
  }

  Future<int> readCounter() async {
    try{
      final file = await _localFile;

      String content = await file.readAsString();

      return int.parse(content);
    }catch(e){
      return 0;
    }
  }

  Future<File> writeCounter(int counter) async {
    final file = await _localFile;

    return file.writeAsString('$counter');
  }


}