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
        duration: const Duration(milliseconds: 500),
        vsync: this
    );
    tween = new ArcListTween(
        new ArcList.empty(this.arcList),
        this.arcList
    );
    animation.forward();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Expense Analysis'),
        bottom: new PreferredSize(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Container(
                  padding: const EdgeInsets.all(28.0),
                  child: new Center(
                      child: new Column(
                        children: <Widget>[
                          new CustomPaint(
                            size: new Size(250.0, 250.0),
                            painter: new ArcPainter(tween.animate(animation)),
                          ),
                          new Text(
                            '10000',

                          )
                        ],
                      )
                  ),
                )
              ],
            ),
            preferredSize: new Size(200.0, 300.0)
        ),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.dehaze),
              color: Colors.white,
              onPressed: null
          )
        ],
      ),
      bottomNavigationBar: new BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                title: new Text('home')
            ),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                title: new Text('home')
            ),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                title: new Text('home')
            ),
          ]
      ),
      floatingActionButton: new FloatingActionButton(
          onPressed: null,
          child: new Icon(Icons.add),
      ),
      drawer: new Drawer(
        child: new ListView(),
      ),
    );
  }
}