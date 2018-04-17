import 'dart:io';
import 'package:test/test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:exp_an/storage/counter_storage.dart';


main(){

  group(
    'FileStorage',
    (){
      setUpAll(
          () async {
            final directory = await Directory.systemTemp.createTemp();

            const MethodChannel('plugins.flutter.io/path_provider')
                .setMockMethodCallHandler((MethodCall methodCall) async {
              if (methodCall.method == 'getApplicationDocumentsDirectory') {
                return directory.path;
              }
              return null;
            });
          }
      );
    }
  );
}