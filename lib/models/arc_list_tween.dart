import 'package:flutter/material.dart';
import 'arc_list.dart';

class ArcListTween extends Tween<ArcList> {
  ArcListTween(ArcList begin, ArcList end):super(begin: begin, end: end);

  @override
  ArcList lerp(double t) {
    return ArcList.lerp(begin, end, t);
  }
}