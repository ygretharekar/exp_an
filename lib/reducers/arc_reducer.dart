import 'package:redux/redux.dart';
import 'package:exp_an/actions/actions.dart';
import 'package:exp_an/models/models.dart';

ArcList _addArc(ArcList arcList, AddArc action){
  return arcList.addArc(action.arc);
}

final Reducer<ArcList> arcReducer = combineReducers([
  new TypedReducer<ArcList, AddArc>(_addArc)
]);