import 'package:flutter/material.dart';
import 'package:exp_an/models/models.dart';
import 'package:exp_an/daypicker/show_day_picker.dart';
import 'dart:async';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:exp_an/actions/actions.dart';
import 'select_trans_screen.dart';

class AddEditScreen extends StatefulWidget {

  final bool isEditing = false;
  final Transaction addTrans = new Transaction(0.0, '');

  AddEditScreen();

  @override
  State createState() {
    return new _AddEditScreenState(isEditing, addTrans);
  }
}

class _AddEditScreenState extends State<AddEditScreen> {

  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  static final GlobalKey<FormFieldState<double>> _costKey =
      new GlobalKey<FormFieldState<double>>();

  static final GlobalKey<FormFieldState<String>> _descKey =
      new GlobalKey<FormFieldState<String>>();

  final bool isEditing;

  final Transaction saveTrans;

  bool period = false;

  List<DateTime> dates;

  double _cost = 0.0;
  String _description;
  Categories _categories;
  bool _periodic;
  String _uuid;
  bool _important;

  _AddEditScreenState(this.isEditing,  this.saveTrans);

  @override
  void initState() {
    super.initState();
    _cost = isEditing ? saveTrans.cost:0.0;
    _description = isEditing ? saveTrans.description:'';
    _categories = isEditing ? saveTrans.category:Categories.miscellaneous;
    _periodic = isEditing ? saveTrans.periodic:false;
    _uuid = isEditing ? saveTrans.uuid:'';
    _important = isEditing ? saveTrans.important:false;
  }

  @override
  Widget build(BuildContext context) {

    ///////////

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          isEditing ? 'Edit Transaction': 'Add Transaction'
        ),
      ),

      body: new Padding(
          padding: new EdgeInsets.all(16.0),
          child: new Form(
              key: _formKey,
              child: new ListView(
                children: <Widget>[
                  new CheckboxListTile(
                      title: new Text('Periodic: '),
                      value: period,
                      onChanged: (bool value){
                        const List<int> _kDaysInMonth = const <int>[31,
                        -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

                        int getDaysInMonth(int year, int month) {
                          if (month == DateTime.february) {
                            final bool isLeapYear = (year % 4 == 0)
                                && (year % 100 != 0)
                                || (year % 400 == 0);
                            if (isLeapYear)
                              return 29;
                            return 28;
                          }
                          return _kDaysInMonth[month - 1];
                        }

                        DateTime date = new DateTime.now();

                        int daysInMonth = getDaysInMonth(
                            date.year,
                            date.month
                        );

                        DateTime fistDate = new DateTime(date.year, date.month, 1);

                        DateTime lastDate = fistDate.add(
                            new Duration(days: daysInMonth - 1)
                        );

                        if(!period){

                          _periodic = !period;

                          Future<List<DateTime>> dateValues = showDayPicker(
                              context: context,
                              initialDate: new DateTime.now(),
                              firstDate: fistDate.add(new Duration(days: date.day - 1)),
                              lastDate: lastDate
                          );

                          dateValues.then(
                                  (value){
                                setState(
                                        (){
                                      dates = value;
                                    }
                                );
                              }
                          );
                        }
                        setState((){period = !period;});
                      }
                  ),

                  new TextFormField(
                    initialValue: _description,
                    autofocus: isEditing,
                    key: _descKey,
                    decoration: new InputDecoration(
                      hintText: 'Description',
                      labelText: 'Description'
                    ),
                    validator: (val){
                      return val.trim().isEmpty ?
                          'Empty Error':
                          null;
                    },
                  ),
                  new TextFormField(
                    key: _costKey,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.right,
                    decoration: new InputDecoration(
                      labelText: 'Price',
                    ),
                    validator: (String value) {
                      _cost = double.parse(value);
                      if(_cost == null) {
                        return '"$value" is not a valid number';
                      }

                      if(_cost == 0.0) {
                        return '"$value" price cannot be zero';
                      }

                      return null;
                    },
                  ),

                  new Padding(
                    padding: new EdgeInsets.only(top: 33.0),
                    child: new ListTile(
                      leading: const Text('Category: '),
                      trailing: new DropdownButton(
                          value: _categories,
                          items: Categories.values.map(
                                  (cat) => new DropdownMenuItem<Categories>(
                                value: cat,
                                child: new Text(
                                    cat.toString().split('.')[1].toUpperCase()
                                ),
                              )
                          ).toList(),
                          onChanged: (Categories value){
                            setState((){
                              _categories = value;
                            });
                          }
                      ),
                    ),
                  ),

                  new CheckboxListTile(
                      title: new Text('Important: '),
                      value: _important,
                      onChanged: (bool value){
                        setState(
                            (){
                              _important = value;
                            }
                        );
                      }
                  ),
                ],
              ),
          ),
      ),

      floatingActionButton: new StoreConnector<AppState, VoidCallback>(
          builder: (BuildContext context, callback){
            return new FloatingActionButton(
              onPressed: callback,
              tooltip: 'Save Transaction',
              child: new Icon(Icons.forward),
            );
          },

          converter: (Store<AppState> store) => () {
            if(_formKey.currentState.validate()){

              Transaction trans = new Transaction(
                  _cost,
                  _descKey.currentState.value,
                  category: _categories,
                  periodic: _periodic,
                  important: _important,
                  occurrences: _periodic ? dates: []
              );

              List<int> sendList = <int>[];

              dates?.forEach(
                  (date){
                    sendList.add(int.parse(date.toString().split('-')[2].split(' ')[0]) - 1);
                  }
              );

              if(dates != null) store.dispatch(new Recurring(trans, sendList));

              final DateTime date = new DateTime.now();

              List<Transaction> aList = store.state.recurring[date.day];

              dates == null ? aList.add(trans):aList;

              /*aList.forEach(
                  (t){
                    print('Trans: $t');
                  }
              );*/

//              store.dispatch(new AddTrans(trans));

//              Navigator.pushNamed(context, '/confirmTransactions');

              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new AnimatedListSample(
                          aList,
                          (List<Transaction> finalList){
                            finalList?.forEach(
                                (t) {
                                  store.dispatch(new AddTrans(t));
                                }
                            );
                          }
                      )
                ),
              );

            }
          }
      ),
    );
  }
}