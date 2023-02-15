import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:music_player/api/dio_client.dart';
import 'package:music_player/features/Dashboard/data/models/music_model.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<GetMusics>((event, emit) async {
      Music? music = await getMusics();
      emit(DashboardLoaded(music));
    });

    on<PlayMusic>((event, emit) {
      onPlayMusic(data: event.musicResult);
    });
  }

  Future<Music?> getMusics() async {
    Music? musics;
    musics = await DioClient().getMusic();
    return musics;
  }

  onPlayMusic({required Result data}) {
    //
  }
}
