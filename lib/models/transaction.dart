import 'models.dart';
import 'package:uuid/uuid.dart';

class Transaction {
  final double cost;
  final DateTime dateTime;
  final String description;
  final Categories category;
  final bool periodic;
  final String uuid;
  final bool important;
  final List<DateTime> occurrences;

  Transaction(
    this.cost,
    this.description,
    {
        DateTime dateTime,
        this.category = Categories.miscellaneous,
        this.periodic = false,
        String uuid,
        this.important = false,
        this.occurrences = const <DateTime>[]
    }
  ):this.uuid = uuid ?? new Uuid().v1(),
    this.dateTime = dateTime ?? new DateTime.now();


  Map<String, Object> toJson() {
    return {
      'cost': cost,
      'description': description,
      'dateTime': dateTime.toString(),
      'category': category.toString(),
      'periodic': periodic.toString(),
      'important': important.toString(),
      'uuid': uuid
    };
  }

}













