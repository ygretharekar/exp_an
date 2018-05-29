import 'package:redux/redux.dart';
import 'package:exp_an/actions/actions.dart';
import 'package:exp_an/models/models.dart';

ArcList _addArc(ArcList arcList, AddArc action){
  return arcList.addArc(action.arc);
}

ArcList _loadArcs(ArcList arcList, LoadArcs action){
  return new ArcList(action.list);
}

final Reducer<ArcList> arcReducer = combineReducers([
  new TypedReducer<ArcList, AddArc>(_addArc),
  new TypedReducer<ArcList, LoadArcs>(_loadArcs),
]);