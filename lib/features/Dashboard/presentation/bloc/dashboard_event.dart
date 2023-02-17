part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent {}

class GetMusics extends DashboardEvent {
  final String? keyword;
  GetMusics({this.keyword});
}

class SearchMusic extends DashboardEvent {}

class PlayMusic extends DashboardEvent {
  final Result musicResult;
  PlayMusic(this.musicResult);
}
