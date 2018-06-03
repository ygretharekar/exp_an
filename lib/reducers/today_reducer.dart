import 'package:redux/redux.dart';
import 'package:exp_an/actions/actions.dart';
import 'package:exp_an/models/models.dart';


List<Transaction> _loadToday(List<Transaction> tList, LoadToday action) =>
    action.list;

final Reducer<List<Transaction>> todayReducer = combineReducers([
  new TypedReducer<List<Transaction>, LoadToday>(_loadToday),
]);
