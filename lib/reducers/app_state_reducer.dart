import 'package:exp_an/models/models.dart';
import 'counter_reducers.dart';

AppState appReducer(AppState state, action) =>
    new AppState(
      count: counterReducer(state.count, action)
    );
