import 'package:flutter/material.dart';
import 'package:exp_an/containers/setting_page_container.dart';

class Setting extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new SettingContainer(
        builder: (BuildContext context, VoidCallback clean){
          return new Container(
            child: new Center(
              child: new IconButton(
                  icon: new Icon(Icons.delete_forever),
                  onPressed: clean
              ),
            ),
          );
        }
    );
  }
}