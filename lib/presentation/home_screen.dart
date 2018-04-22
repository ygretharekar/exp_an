import 'package:flutter/material.dart';
import 'package:exp_an/models/models.dart';
import 'package:exp_an/containers/active_tab.dart';
import 'counter_page.dart';
import 'draw_arc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ActiveTab(
        builder: (BuildContext context, AppState state){
          return state.tab == AppTab.arc ?
              new DrawArc(state.arcList):
              new CounterPage();
        }
    );
  }
}