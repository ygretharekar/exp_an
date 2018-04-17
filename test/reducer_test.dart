import 'package:redux/redux.dart';
import 'package:exp_an/models/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:exp_an/reducers/app_state_reducer.dart';
import 'package:exp_an/actions/actions.dart';

main(){
  group(
      'State Reducer',
      (){
        test(
            'Should add 1 in response to AddOne',
            (){
              final store = new Store<AppState>(
                appReducer,
                initialState: new AppState()
              );

              int count = store.state.count;

              store.dispatch(new AddOne());

              expect(store.state.count, count + 1);
            }
        );
      }
  );
}