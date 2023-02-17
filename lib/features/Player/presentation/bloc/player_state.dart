part of 'player_bloc.dart';

@immutable
abstract class PlayerState {}

class PlayerInitial extends PlayerState {}

class PlayerOnPause extends PlayerState {
  final double position;
  PlayerOnPause(this.position);
}

class PlayerOnSeekBackward extends PlayerState {}

class PlayerOnSeekForward extends PlayerState {}

class PlayerOnCompleted extends PlayerState {}

class PlayerOnPlaying extends PlayerState {
  final double progress;
  PlayerOnPlaying(this.progress);
}
