import 'package:redux/redux.dart';
import 'package:exp_an/actions/actions.dart';
import 'package:exp_an/models/models.dart';

List<Transaction> _addTrans(List<Transaction> tList, AddTrans action){

  List<Transaction> myList = tList.map((e) => e).toList(growable: true)
                                ..add(action.transaction);

  return myList;
}

List<Transaction> _loadTrans(List<Transaction> tList, LoadTrans action) =>
  action.trans;

List<Transaction> _editTrans(List<Transaction> tList, EditTrans action){
  //  int i = 0;
  tList.forEach(
      (t){
        if(t.uuid == action.uuid){
        }
        //        else i++;
      }
  );
  return tList;
}

final Reducer<List<Transaction>> transReducer = combineReducers([
  new TypedReducer<List<Transaction>, AddTrans>(_addTrans),
  new TypedReducer<List<Transaction>, EditTrans>(_editTrans),
  new TypedReducer<List<Transaction>, LoadTrans>(_loadTrans),
]);
