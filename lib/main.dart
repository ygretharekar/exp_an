import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:exp_an/actions/actions.dart';
import 'package:exp_an/models/models.dart';
import 'reducers/app_state_reducer.dart';
import 'middlewares/middlewares.dart';
import 'package:exp_an/presentation/home_screen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  final store = new Store<AppState>(
    appReducer,
    initialState: new AppState(),
    middleware: createMiddleware()
  );

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
        store: store,
        child: new MaterialApp(
          title: 'ExpAn',
          home: new StoreBuilder<AppState>(
              onInit: (store) => store.dispatch(new GetCount()),
              builder: (context, store){
                return new HomeScreen();
              }
          ),
        )
    );
  }
}