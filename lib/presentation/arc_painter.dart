import 'package:flutter/material.dart';
import 'package:exp_an/models/models.dart';
import 'dart:ui';

class ArcPainter extends CustomPainter {
  final Animation<ArcList> animation;
  final String funds;

  ArcPainter(Animation<ArcList> animation, {this.funds = '10000'}):
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

    var money = '\u{20B9}';

    TextSpan rupee;

    TextStyle style = new TextStyle(
        color: Colors.white70
    );

    rupee = new TextSpan(
        text: money,
        style: style
    );

    TextPainter rp = new TextPainter(
      text: rupee,
      textDirection: TextDirection.ltr,
      textScaleFactor: 3.0
    );

    rp.layout();

    rp.paint(
        canvas,
        new Offset(size.width/2 - rp.width/2, size.height/2 - 80.0)
    );

    TextSpan span = new TextSpan(
        text: funds,
        style: new TextStyle(
          color: Colors.white,
          fontFamily: 'Gugi'
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
        new Offset(size.width/2 - tp.width/2, size.height/2 - 20.0)
    );


    TextSpan rem = new TextSpan(
        text: 'remaining',
        style: new TextStyle(
          color: Colors.white70,
          fontFamily: 'Do_Hyeon'
        )
    );

    TextPainter remp = new TextPainter(
        text: rem,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr
    );

    remp.layout();

    remp.paint(
        canvas,
        new Offset(size.width/2 - remp.width/2, size.height/2 + 50.0)
    );

  }


  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

}