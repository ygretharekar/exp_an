import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:exp_an/models/models.dart';

class FundsContainer extends StatelessWidget {
  final ViewModelBuilder<double> builder;

  FundsContainer(this.builder);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, double>(
        builder: builder,
        converter: (Store<AppState> store) => store.state.initialFunds
    );
  }
}