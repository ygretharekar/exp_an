import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:exp_an/models/models.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ActiveTab extends StatelessWidget {
  final ViewModelBuilder<AppState> builder;

  ActiveTab({Key key, @required this.builder}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
        distinct: true,
        builder: builder,
        converter: (Store<AppState> store) =>
            store.state
    );
  }
}
