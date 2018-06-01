import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:exp_an/models/models.dart';

class DrawerContainer extends StatelessWidget {
  final ViewModelBuilder<List<Map<String, Object>>> builder;

  DrawerContainer(this.builder);


  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, List<Map<String, Object>>>(
        builder: builder,
        converter: (Store<AppState> store) => store.state.drawer
    );
  }
}