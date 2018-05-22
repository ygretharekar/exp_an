import 'package:exp_an/models/models.dart';

class AddOne{}

class GetCount{}

class SetCount{
  final int count;

  SetCount(this.count);
}

class AddArc{
  final ArcData arc;

  AddArc(this.arc);
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