import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc() : super(PlayerInitial()) {
    AudioPlayer audioPlayer = AudioPlayer();
    late double currentTrackTime;
    late bool isPaused;
    audioPlayer.onPositionChanged.listen((duration) {
      add(Progress(duration.inMilliseconds.toDouble() / 100000));
    });

    audioPlayer.onPlayerComplete.listen((_) {
      add(Completed());
    });

    on<Play>((event, emit) async {
      isPaused = false;
      await audioPlayer.play(UrlSource(event.musicUrl));
    });

    on<Progress>((event, emit) async {
      if (!isPaused) {
        emit(PlayerOnPlaying(event.duration));
        currentTrackTime = event.duration;
      } else {
        emit(PlayerOnPause(currentTrackTime));
      }
    });

    on<Pause>((event, emit) async {
      isPaused = true;
      await audioPlayer.pause();
    });

    on<Completed>((event, emit) async {
      emit(PlayerOnCompleted());
      isPaused = true;
    });

    on<Seek>((event, emit) async {
      audioPlayer.seek(Duration(seconds: (event.position * 10 + 2).ceil()));
    });

    on<Backward>((event, emit) async {
      Duration? current = await audioPlayer.getCurrentPosition();
      audioPlayer.seek(Duration(seconds: current!.inSeconds - 5));
    });

    on<Forward>((event, emit) async {
      Duration? current = await audioPlayer.getCurrentPosition();
      audioPlayer.seek(Duration(seconds: current!.inSeconds + 5));
    });
  }
}
