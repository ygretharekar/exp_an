import 'package:flutter/material.dart';
import 'package:exp_an/models/models.dart';
import 'arc_painter.dart';
import 'package:exp_an/containers/trans_list.dart';
import 'package:exp_an/containers/arc_container.dart';
import 'setting_widget.dart';
import 'package:exp_an/containers/drawer_container.dart';

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
      child: new Setting(),
    ),
    new Text('Page 1'),
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
    return new ArcContainer(
        builder: (BuildContext context, AppState state){

          ArcList arcList = state.arcList;

          tween = new ArcListTween(
              new ArcList.empty(arcList),
              arcList
          );

          animation.forward(from: 0.0);

          double spent = 0.0;

          state.transactions.forEach(
                  (t) => spent += t.cost
          );

          double remaining = 10000.0 - spent;

          String funds = remaining.floor().toString();

          const List<int> _kDaysInMonth = const <int>[31,
          -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

          int _getRemainingDaysInMonth(int year, int month, int date) {
            if (month == DateTime.february) {
              final bool isLeapYear = (year % 4 == 0)
                  && (year % 100 != 0)
                  || (year % 400 == 0);
              if (isLeapYear)
                return 29;
              return 28;
            }
            return _kDaysInMonth[month - 1] - date;
          }

          DateTime date = new DateTime.now();

          double _csr = spent/date.day;

          double _rsr = remaining/_getRemainingDaysInMonth(date.year, date.month, date.day);

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
                                  painter: new ArcPainter(tween.animate(animation), funds: funds),
                                ),
                              ],
                            )
                        ),
                      )
                    ],
                  ),
                  preferredSize: new Size(200.0, 300.0)
              ):
              null
            ),

            body: this._index == 1 ?
                new GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(20.0),
                  crossAxisSpacing: 3.0,
                  crossAxisCount: 2,
                  children: <Widget>[
                    new Column(
                      children: <Widget>[
                        const Text(
                            'Current Spending Rate',
                            textScaleFactor: 1.5,
                            textAlign: TextAlign.center,
                        ),
                        new Text('${_csr.floor()}/day'),
                        new Text('Till today'),
                      ],
                    ),
                    new Column(
                      children: <Widget>[
                        const Text(
                            'Required Spending Rate',
                            textScaleFactor: 1.5,
                            textAlign: TextAlign.center,
                        ),
                        new Text('${_rsr.ceil()}/day'),
                        new Text('Till end of the month'),
                      ],
                    ),
                  ],
                )
                :pages[this._index],

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

            drawer: new DrawerContainer(
                (context, List<Map<String, Object>> list){
                  return _index == 1 ? new Drawer(
                      child: new ListView(
                        children: list.map(
                          (i){
                            return new ListTile(
                              leading: new CircleAvatar(
                                backgroundColor: i['color'],
                              ),
                              title: new Text(i['price'].toString()),
                              subtitle: new Text(i['category'].toString().split('.')[1]),
                            );
                          }
                        ).toList()
                      )
                  ): null;
                }
            ),
          );
        }
    );
  }
}
