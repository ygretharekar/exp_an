import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:exp_an/models/models.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:exp_an/actions/actions.dart';

class SettingContainer extends StatelessWidget {
  final ViewModelBuilder<VoidCallback> builder;

  SettingContainer({Key key, @required this.builder}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, VoidCallback>(
        distinct: true,
        builder: builder,
        converter: (Store<AppState> store) => () {
          store.dispatch(new ClearData());
        }
    );
  }
}