part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final Music? musics;
  DashboardLoaded(this.musics);
}
