import 'arc_data.dart';

class ArcList {

  final List<ArcData> arcs;

  ArcList(this.arcs);

  factory ArcList.empty(ArcList arcList){

    List<ArcData> listArc = [];

    for(int i = 0; i < arcList.arcs.length; i++ ){
      listArc.add(
          new ArcData(
              startAngle: arcList.arcs[i].startAngle,
              angle: 0.0
          )
      );
    }
    return new ArcList(listArc);
  }

  ArcList addArc(ArcData arc){
    arcs.add(arc);
    return new ArcList(
      arcs
    );
  }

  static ArcList lerp(ArcList begin, ArcList end, double t){

    List<ArcData> ans = new List.generate(
        begin.arcs.length,
        (i) => ArcData.lerp(
              begin.arcs[i],
              end.arcs[i],
              t
        )
    );

    return new ArcList(ans);
  }
}