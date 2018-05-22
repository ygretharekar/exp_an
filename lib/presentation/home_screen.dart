import 'package:flutter/material.dart';
import 'package:exp_an/models/models.dart';
import 'draw_arc.dart';

class HomeScreen extends StatelessWidget {
  final ArcList arcList;
  HomeScreen(this.arcList);

  @override
  Widget build(BuildContext context) {
    return new DrawArc(arcList);
  }
}