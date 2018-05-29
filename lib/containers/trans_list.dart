import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:exp_an/actions/actions.dart';
import 'package:exp_an/models/models.dart';
import 'package:exp_an/presentation/trans_list_widget.dart';

class TransList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, List<Transaction>>(
        builder: (BuildContext context, List<Transaction> transactions){
          return new TransListWidget(transactions);
        },
        converter: (Store<AppState> store) => store.state.transactions
    );
  }
}