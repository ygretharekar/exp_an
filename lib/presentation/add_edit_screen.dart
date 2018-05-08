import 'package:flutter/material.dart';
import 'package:exp_an/models/models.dart';
import 'package:exp_an/daypicker/show_day_picker.dart';
import 'dart:async';

class AddEditScreen extends StatefulWidget {

  final bool isEditing;
  final Function(Transaction) addTrans;

  AddEditScreen(this.isEditing, this.addTrans);

  @override
  State createState() {
    return new _AddEditScreenState(isEditing, addTrans);
  }
}

class _AddEditScreenState extends State<AddEditScreen> {

  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  final bool isEditing;

  final Function(Transaction) saveTrans;

  bool period = false;

  List<DateTime> dates;

  _AddEditScreenState(this.isEditing,  this.saveTrans);

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Transaction transaction = new Transaction();

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
                  new Padding(
                    padding: new EdgeInsets.only(top: 33.0),
                    child: new ListTile(
                      leading: const Text('Category: '),
                      trailing: new DropdownButton(
                          items: Categories.values.map(
                                  (cat) => new DropdownMenuItem(
                                  child: new Text(cat.toString().split('.')[1])
                              )
                          ).toList(),
                          onChanged: null




                      ),
                    ),
                  ),
                  new TextFormField(
                    initialValue: isEditing ? transaction.description:'',
                    autofocus: isEditing,
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
                    initialValue: isEditing ? transaction.cost:'',
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      hintText: 'Price',
                      labelText: 'Price'
                    ),
                    validator: (val){
                      double cost = double.parse(val);
                      return cost.isFinite ? 'Error':null;
                    },
                  ),

                  new CheckboxListTile(
                      title: new Text('Periodic: '),
                      value: period,
                      onChanged: (bool value){

                      }
                  ),

                  new ListTile(
                      leading: const Icon(Icons.access_time),
                      trailing: new IgnorePointer(
                        ignoring: !period,
                        child: new DropdownButton(
                            hint: new Text( 'Disabled' ),
                            items: Periodic.values.map(
                                    (cat) => new DropdownMenuItem(
                                    child: new Container(
                                      child: new Row(
                                        children: <Widget>[
                                          new Text(cat.toString().split('.')[1])
                                        ],
                                      ),
                                    )
                                )
                            ).toList(),
                            onChanged: null
                        )
                      ),
                      enabled: true,
                      onTap: () {/* react to the tile being tapped */ }
                  ),
                  new Text(
                    dates.toString()
                  )

                ],
              ),
          ),
      ),
    );
  }

}