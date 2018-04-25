import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:ui' show lerpDouble;

class ArcData {
  final double startAngle;
  final double angle;
  final Color color;

  ArcData({
    @required this.startAngle,
    @required this.angle,
    this.color = Colors.white
  });



  static ArcData lerp(ArcData begin, ArcData end, double t) =>
      new ArcData(
          startAngle: begin.startAngle,
          angle: lerpDouble(0.0, end.angle, t),
          color: Color.lerp(Colors.white, end.color, t)
      );

}