import 'package:flutter/material.dart';
import 'package:exp_an/models/models.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:exp_an/presentation/add_edit_screen.dart';
import 'package:exp_an/actions/actions.dart';

class AddTransaction extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return
      new StoreConnector<AppState, Function(Transaction)>(
        builder: (BuildContext context, Function(Transaction) addTrans){

          return new AddEditScreen();
        },
        converter: (Store<AppState> store){
          return (Transaction transaction) =>
              store.dispatch(new AddTrans(transaction));
        }
    );
  }

}