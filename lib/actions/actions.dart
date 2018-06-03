import 'package:exp_an/models/models.dart';

class AddOne{}

class GetCount{}

class SetCount{
  final int count;

  SetCount(this.count);
}

class GetArcs{
  GetArcs();
}

class AddArc{
  final ArcData arc;

  AddArc(this.arc);
}

class LoadArcs{
  final List<ArcData> list;

  LoadArcs(this.list);
}


class AddTrans{
  final Transaction transaction;

  AddTrans(this.transaction);
}

class EditTrans{
  final String uuid;

  EditTrans(this.uuid);
}

class GetTrans{
  GetTrans();
}

class LoadTrans{
  List<Transaction> trans;

  LoadTrans(this.trans);
}

class ClearData {
  ClearData();
}

class UpdateDrawer {

  final List<Map<String, Object>> drawer;

  UpdateDrawer(this.drawer);
}

class UpdateFunds {

  final double funds;

  UpdateFunds(this.funds);

}

class Recurring {
  final Transaction transaction;

  final List<int> list;

  Recurring(this.transaction, this.list);

}

class LoadRecurring {
  final List<List<Transaction>> list;

  LoadRecurring(this.list);
}

class GetRecurring {
  GetRecurring();
}

class LoadToday {
  final List<Transaction> list;

  LoadToday(this.list);


}