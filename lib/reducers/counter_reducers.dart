import 'package:redux/redux.dart';
import 'package:exp_an/actions/actions.dart';

int _addOne(int count, AddOne action) => count + 1;

int _readCount(int count, SetCount action) => action.count;

int _getCount(int count, GetCount action) => count;

final Reducer<int> counterReducer = combineReducers([
  new TypedReducer<int, AddOne>(_addOne),
  new TypedReducer<int, SetCount>(_readCount),
  new TypedReducer<int, GetCount>(_getCount)
]);
