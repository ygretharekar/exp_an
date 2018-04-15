import 'models.dart';

class AppState{

  final bool isLoading;
  final int count;
  final AppTab tab;

  AppState({
    this.isLoading = false,
    this.count = 0,
    this.tab = AppTab.progress
  });
}
