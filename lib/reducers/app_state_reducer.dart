import 'package:exp_an/models/models.dart';
import 'counter_reducers.dart';
import 'arc_reducer.dart';
import 'trans_reducer.dart';
import 'drawer_reducer.dart';
import 'total_reducer.dart';

AppState appReducer(AppState state, action) =>
    new AppState(
        count: counterReducer(state.count, action),
        arcList: arcReducer(state.arcList, action),
        transactions: transReducer(state.transactions, action),
        drawer: drawerReducer(state.drawer, action),
        initialFunds: fundsReducer(state.initialFunds, action)
    );
