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