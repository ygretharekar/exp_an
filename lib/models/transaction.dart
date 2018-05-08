import 'models.dart';

class Transaction {
  final double cost;
  final DateTime dateTime;
  final String description;
  final Categories category;
  final bool periodic;
  final Periodic period;

  Transaction(
    {
        this.cost = 0.0,
        this.dateTime,
        this.description,
        this.category = Categories.miscellaneous,
        this.periodic,
        this.period
    }
  );

}