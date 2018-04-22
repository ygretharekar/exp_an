import 'package:flutter/material.dart';
import 'package:exp_an/models/models.dart';

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
                      ..strokeWidth = 4.0;

    final rect = new Rect.fromLTWH(0.0, 0.0, 200.0, 200.0);

    canvas.drawArc(
        rect,
        2.35619,
        4.71239,
        false,
        paint
    );

    paint.strokeWidth = 3.0;

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
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

}