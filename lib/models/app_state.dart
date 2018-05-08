import 'models.dart';

class AppState{

  final bool isLoading;
  final int count;
  final AppTab tab;
  final double initialFunds;
  final ArcList arcList;
  final List<Transaction> transactions;

  AppState({
    this.isLoading = false,
    this.count = 0,
    this.tab = AppTab.arc,
    this.initialFunds = 10000.0,
    this.arcList,
    this.transactions
  });

}