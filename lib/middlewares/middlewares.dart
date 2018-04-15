import 'package:redux/redux.dart';
import 'package:exp_an/models/models.dart';
import 'package:exp_an/storage/counter_storage.dart';
import 'package:exp_an/actions/actions.dart';

Middleware<AppState> _writeAddOne(CounterStorage file)  =>
    (Store<AppState> store, action, NextDispatcher next) async {
      next(action);

      return file.writeCounter(store.state.count);
    };

Middleware<AppState> _readCount(CounterStorage file) =>
    (Store<AppState> store, action, NextDispatcher next) async {
      file
          .readCounter()
          .then(
            (count) => store.dispatch(new SetCount(count))
          );

      next(action);
    };

List<Middleware<AppState>> createMiddleware([
  CounterStorage storage =  const CounterStorage()
]){
  final Middleware<AppState> readCount = _readCount(storage);
  final Middleware<AppState> writeCount = _writeAddOne(storage);

  return <Middleware<AppState>>[
    new TypedMiddleware<AppState, AddOne>(writeCount),
    new TypedMiddleware<AppState, GetCount>(readCount)
  ];
}
