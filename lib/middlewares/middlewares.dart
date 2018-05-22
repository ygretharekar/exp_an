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
      file
            .loadTrans()
            .then(
                (trans){
                  store.dispatch(new LoadTrans(trans));
                }
            );

      next(action);
    };

Middleware<AppState> _saveTrans(TransStorage file) =>
    (Store<AppState> store, action, NextDispatcher next) async {
      next(action);
      
      file
            .saveTrans(store.state.transactions);
    };

List<Middleware<AppState>> createMiddleware([
//  CounterStorage storage =  const CounterStorage(),
  TransStorage storage = const TransStorage()
]){
//  final Middleware<AppState> readCount = _readCount(storage);
//  final Middleware<AppState> writeCount = _writeAddOne(storage);
  final Middleware<AppState> loadTrans = _loadTrans(storage);
  final Middleware<AppState> saveTrans = _saveTrans(storage);


  return <Middleware<AppState>>[
//    new TypedMiddleware<AppState, AddOne>(writeCount),
//    new TypedMiddleware<AppState, GetCount>(readCount),
    new TypedMiddleware<AppState, GetTrans>(loadTrans),
    new TypedMiddleware<AppState, AddTrans>(saveTrans),
    new LoggingMiddleware.printer()
  ];

}
