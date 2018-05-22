import 'package:flutter/material.dart';
import 'package:exp_an/models/models.dart';
import 'arc_painter.dart';
import 'package:exp_an/containers/trans_list.dart';

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

  TabController _tabController;

  int _index;

  List<Widget> pages = [
    new Center(
      child: new Text('Page 0'),
    ),
    new Center(
      child: new Text('Page 1'),
    ),
    new TransList(),
  ];

  @override
  void initState() {
    super.initState();
    animation = new AnimationController(
        duration: const Duration(milliseconds: 1000),
        vsync: this
    );
    tween = new ArcListTween(
        new ArcList.empty(this.arcList),
        this.arcList
    );
    animation.forward();
    _tabController = new TabController(length: 3, vsync: this);
    _index = 1;
  }

  @override
  void dispose() {
    _tabController.dispose();
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
            'Expense Analysis'
        ),

        bottom: _index == 1 ? new PreferredSize(
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
                        ],
                      )
                  ),
                )
              ],
            ),
            preferredSize: new Size(200.0, 300.0)
        ):
        null,
        actions: <Widget>[
        ],
      ),

      body: pages[this._index],

      bottomNavigationBar:  new BottomNavigationBar(
          currentIndex: _index,
          onTap: (int _i){
            setState(
                (){
                  this._index = _i;
                  if(_i == 1) animation.forward(from: 0.0);

                }
            );
          },
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(
                icon: new Icon(Icons.settings),
                title: new Text('setting')
            ),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                title: new Text('home')
            ),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.account_balance_wallet),
                title: new Text('details')
            ),
          ],
      ),

      floatingActionButton: new FloatingActionButton(
          onPressed: (){
            Navigator.pushNamed(context, '/addTransaction');
          },
          child: new Icon(Icons.add),
      ),

      drawer: _index == 1 ? new Drawer(
        child: new ListView(),
      ): null,

    );

  }
}
