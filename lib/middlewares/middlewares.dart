import 'package:redux/redux.dart';
import 'package:exp_an/models/models.dart';
import 'package:exp_an/actions/actions.dart';
import 'package:exp_an/storage/trans_storage.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:flutter/material.dart';

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

const int initialCost = 10000;

Middleware<AppState> _loadTrans(TransStorage file) =>
    (Store<AppState> store, action, NextDispatcher next) async {
      List<Map<String, Object>> list = [
        {
          'category': Categories.food,
          'price': 0.0,
          'color':  Colors.green
        },
        {
          'category': Categories.miscellaneous,
          'price': 0.0,
          'color':  Colors.black
        },
        {
          'category': Categories.bill,
          'price': 0.0,
          'color':  Colors.amber
        },
        {
          'category': Categories.donation,
          'price': 0.0,
          'color':  Colors.pinkAccent
        },
        {
          'category': Categories.entertainment,
          'price': 0.0,
          'color':  Colors.redAccent
        },
        {
          'category': Categories.fee,
          'price': 0.0,
          'color':  Colors.brown
        },
        {
          'category': Categories.grocery,
          'price': 0.0,
          'color':  Colors.blue
        },
        {
          'category': Categories.lend,
          'price': 0.0,
          'color':  Colors.deepPurple
        },
        {
          'category': Categories.service,
          'price': 0.0,
          'color':  Colors.orange
        },
        {
          'category': Categories.ticket,
          'price': 0.0,
          'color':  Colors.cyanAccent
        },
        {
          'category': Categories.transport,
          'price': 0.0,
          'color':  Colors.indigo
        }
      ];

      await file
            .loadTrans()
            .then(
                (trans){

                  list.forEach(
                    (item){
                      double price = 0.0;

                      trans.forEach(
                          (t){
                            if(item['category'] == t.category) price += t.cost;
                          }
                      );
                      item['price'] = price;
                    }
                  );

                  store.dispatch(new UpdateDrawer(list));

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

      List<Map<String, Object>> list = [
        {
          'category': Categories.food,
          'price': 0.0,
          'color':  Colors.green
        },
        {
          'category': Categories.miscellaneous,
          'price': 0.0,
          'color':  Colors.black
        },
        {
          'category': Categories.bill,
          'price': 0.0,
          'color':  Colors.amber
        },
        {
          'category': Categories.donation,
          'price': 0.0,
          'color':  Colors.pinkAccent
        },
        {
          'category': Categories.entertainment,
          'price': 0.0,
          'color':  Colors.redAccent
        },
        {
          'category': Categories.fee,
          'price': 0.0,
          'color':  Colors.brown
        },
        {
          'category': Categories.grocery,
          'price': 0.0,
          'color':  Colors.blue
        },
        {
          'category': Categories.lend,
          'price': 0.0,
          'color':  Colors.deepPurple
        },
        {
          'category': Categories.service,
          'price': 0.0,
          'color':  Colors.orange
        },
        {
          'category': Categories.ticket,
          'price': 0.0,
          'color':  Colors.cyanAccent
        },
        {
          'category': Categories.transport,
          'price': 0.0,
          'color':  Colors.indigo
        }
      ];



      await file
            .saveTrans(store.state.transactions);

      list.forEach(
              (item){
            double price = 0.0;

            store.state.transactions.forEach(
                    (t){
                  if(item['category'] == t.category) price += t.cost;
                }
            );
            item['price'] = price;
          }
      );

      store.dispatch(new UpdateDrawer(list));

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

          store.dispatch(new AddTrans(new Transaction(0.0, '')));


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
