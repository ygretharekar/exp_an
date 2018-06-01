import 'package:redux/redux.dart';
import 'package:exp_an/actions/actions.dart';

double _updateCost(double funds, UpdateFunds action) => 10000.0 - action.funds;

final Reducer<double> fundsReducer = combineReducers([
  new TypedReducer<double, UpdateFunds>(_updateCost)
]);
