import 'package:flutter/material.dart';
import 'package:exp_an/models/models.dart';
import 'arc_painter.dart';

class DrawArc extends StatefulWidget {
  final ArcList arcList;

  DrawArc(this.arcList);

  @override
  State createState() {
    return new DrawArcState(arcList);
  }
}

class DrawArcState extends State<DrawArc> with TickerProviderStateMixin {
  ArcList arcList;

  DrawArcState(this.arcList);

  AnimationController animation;

  ArcListTween tween;

  @override
  void initState() {
    super.initState();
    animation = new AnimationController(
        duration: const Duration(milliseconds: 5000),
        vsync: this
    );
    tween = new ArcListTween(
        new ArcList.empty(this.arcList),
        this.arcList
    );
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Expense An'),
        bottom: new PreferredSize(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Container(
                  padding: const EdgeInsets.all(28.0),
                  child: new Center(
                      child: new CustomPaint(
                        size: new Size(200.0, 200.0),
                        painter: new ArcPainter(tween.animate(animation)),
                      ),
                  ),
                )
              ],
            ),
            preferredSize: new Size(200.0, 300.0)
        ),
      ),
    );
  }
}