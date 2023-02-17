part of 'player_bloc.dart';

@immutable
abstract class PlayerEvent {}

class Play extends PlayerEvent {
  final String musicUrl;
  Play(this.musicUrl);
}

class Pause extends PlayerEvent {}

class Completed extends PlayerEvent {}

class Backward extends PlayerEvent {}

class Forward extends PlayerEvent {}

class Seek extends PlayerEvent {
  final double position;
  Seek(this.position);
}

class Slide extends PlayerEvent {}

class Progress extends PlayerEvent {
  final double duration;
  Progress(this.duration);
}
