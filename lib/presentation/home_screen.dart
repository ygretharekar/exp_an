import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:exp_an/models/models.dart';
import 'package:exp_an/containers/active_tab.dart';
import 'package:exp_an/actions/actions.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ActiveTab(
        builder: (BuildContext context, AppState state){
          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Exp Analysis'),
            ),
            body: new Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                      'You have pushed button this many times: '
                  ),
                  new Text(
                    state.count.toString(),
                    style: Theme.of(context).textTheme.display1,
                  )
                ],
              ),
            ),
            floatingActionButton: new StoreConnector<AppState, VoidCallback>(
                builder: (BuildContext context, callback){
                  return new FloatingActionButton(
                    onPressed: callback,
                    tooltip: 'Increment',
                    child: new Icon(Icons.add),
                  );
                },
                converter: (Store<AppState> store) =>
                    () => store.dispatch(new AddOne())
            ),
          );
        }
    );
  }

}