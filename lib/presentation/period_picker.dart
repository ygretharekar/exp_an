import 'package:flutter/material.dart';

class PeriodPicker extends StatefulWidget {

  @override
  State createState() {
    return new PeriodPickerState();
  }
}

class PeriodPickerState extends State<PeriodPicker>{

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Period Picker'),
      ),
      body: new Container(
        child: new DayPicker(
            selectedDate: new DateTime.now().add(new Duration(days: 3)),
            currentDate: new DateTime.now(),
            onChanged: (DateTime dt){},
            firstDate: new DateTime.now(),
            lastDate: new DateTime.now().add(new Duration(days: 30)),
            displayedMonth: new DateTime.now()
        ),


      ),


    );
  }

}