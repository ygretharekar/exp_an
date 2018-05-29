import 'package:redux/redux.dart';
import 'package:exp_an/models/models.dart';
//import 'package:exp_an/storage/counter_storage.dart';
import 'package:exp_an/actions/actions.dart';
import 'package:exp_an/storage/trans_storage.dart';
import 'package:redux_logging/redux_logging.dart';

/*Middleware<AppState> _writeAddOne(CounterStorage file)  =>
    (Store<AppState> store, action, NextDispatcher next) async {
      next(action);

      return file.writeCounter(store.state.count);
    };

Middleware<AppState> _readCount(CounterStorage file) =>
    (Store<AppState> store, action, NextDispatcher next) async {
      await file
          .readCounter()
          .then(
            (count) => store.dispatch(new SetCount(count))
          );
      next(action);
    };*/

Middleware<AppState> _loadTrans(TransStorage file) =>
    (Store<AppState> store, action, NextDispatcher next) async {
      await file
            .loadTrans()
            .then(
                (trans){
                  store.dispatch(new LoadTrans(trans));
                }
            );
      next(action);
    };

Middleware<AppState> _loadArcs(TransStorage file) =>
    (Store<AppState> store, action, NextDispatcher next) async {
      await file
            .loadArcList()
            .then(
                (arcs){
                  store.dispatch(new LoadArcs(arcs));
                }
            );
      next(action);
    };

Middleware<AppState> _saveTrans(TransStorage file) =>
    (Store<AppState> store, action, NextDispatcher next) async {
      next(action);

      await file
            .saveTrans(store.state.transactions);

      await file
          .loadArcList()
          .then(
              (arcs){
                store.dispatch(new LoadArcs(arcs));
              }
          );

    };

Middleware<AppState> _cleanFile(TransStorage file) =>
        (Store<AppState> store, action, NextDispatcher next) async {
          next(action);
          file.clean();

          store.dispatch(new LoadTrans([]));

          store.dispatch(new LoadArcs([]));

        };


List<Middleware<AppState>> createMiddleware([
//  CounterStorage storage =  const CounterStorage(),
  TransStorage storage = const TransStorage(10000.0)
]){
//  final Middleware<AppState> readCount = _readCount(storage);
//  final Middleware<AppState> writeCount = _writeAddOne(storage);
  final Middleware<AppState> loadTrans = _loadTrans(storage);
  final Middleware<AppState> saveTrans = _saveTrans(storage);
  final Middleware<AppState> loadArcs = _loadArcs(storage);
  final Middleware<AppState> cleanFile = _cleanFile(storage);

  return <Middleware<AppState>>[
//    new TypedMiddleware<AppState, AddOne>(writeCount),
//    new TypedMiddleware<AppState, GetCount>(readCount),
    new TypedMiddleware<AppState, GetTrans>(loadTrans),
    new TypedMiddleware<AppState, GetArcs>(loadArcs),
    new TypedMiddleware<AppState, AddTrans>(saveTrans),
    new TypedMiddleware<AppState, ClearData>(cleanFile),
    new LoggingMiddleware.printer()
  ];
}
