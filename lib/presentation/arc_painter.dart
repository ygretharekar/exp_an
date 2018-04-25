import 'package:flutter/material.dart';
import 'package:exp_an/models/models.dart';
import 'dart:ui';

class ArcPainter extends CustomPainter {
  final Animation<ArcList> animation;

  ArcPainter(Animation<ArcList> animation):
    animation = animation,
    super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final arcs = animation.value;

    final paint = new Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeCap = StrokeCap.round
                      ..strokeWidth = 30.0;

    final rect = new Rect.fromLTWH(0.0, 0.0, 250.0, 250.0);

    paint.color = Colors.white;

    canvas.drawArc(
        rect,
        2.35619,
        4.71239,
        false,
        paint
    );

    paint.strokeWidth = 20.0;

    arcs.arcs.forEach(
        (arc){
          paint.color = arc.color;
          canvas.drawArc(
              rect,
              arc.startAngle,
              arc.angle,
              false,
              paint
          );
        }
    );



    TextSpan span = new TextSpan(
        text: '10000',
        style: new TextStyle(
          color: Colors.white
        )
    );

    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
        textScaleFactor: 4.0,
    );

    tp.layout();

    tp.paint(
        canvas,
        new Offset(size.width/2 - tp.width/2, size.height/2 - 40.0)
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

}