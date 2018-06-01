import 'package:redux/redux.dart';
import 'package:exp_an/actions/actions.dart';

List<Map<String, Object>> _updatePrices(List<Map<String, Object>> drawer, UpdateDrawer action) =>
    action.drawer;

final Reducer<List<Map<String, Object>>> drawerReducer = combineReducers([
  new TypedReducer<List<Map<String, Object>>, UpdateDrawer>(_updatePrices)
]);
