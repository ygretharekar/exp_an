import 'package:redux/redux.dart';
import 'package:exp_an/actions/actions.dart';
import 'package:exp_an/models/models.dart';

List<List<Transaction>> _recurringTrans(List<List<Transaction>> rList, Recurring action) {

  action.list.forEach(
      (date) => rList[date].add(action.transaction)
  );
//  print('RList: ${rList.toString()}');
  return rList;
}

List<List<Transaction>> _loadRecurring(List<List<Transaction>> rList, LoadRecurring action) =>
    action.list;

final Reducer<List<List<Transaction>>> recurringReducer = combineReducers([
  new TypedReducer<List<List<Transaction>>, Recurring>(_recurringTrans),
  new TypedReducer<List<List<Transaction>>, LoadRecurring>(_loadRecurring),
]);
