import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:exp_an/models/models.dart';
import 'package:exp_an/actions/actions.dart';

class CounterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Exp Analysis'),
      ),
      body: new StoreConnector(
          builder: (BuildContext context, int count){
            return new Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                      'You have pushed button this many times: '
                  ),
                  new Text(
                    count.toString(),
                    style: Theme.of(context).textTheme.display1,
                  )
                ],
              ),
            );
          },
          converter: (Store<AppState> store) => store.state.count
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
}