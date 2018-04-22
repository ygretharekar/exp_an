import 'package:flutter/material.dart';
import 'arc_data.dart';

class ArcTween extends Tween<ArcData> {

  ArcTween(ArcData begin, ArcData end): super(begin: begin, end: end);

  @override
  ArcData lerp(double t) {
    return ArcData.lerp(begin, end, t);
  }
}