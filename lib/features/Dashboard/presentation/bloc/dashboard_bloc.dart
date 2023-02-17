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
      emit(DashboardLoading());
      Music? music =
          await getMusics(keyword: event.keyword == "" ? null : event.keyword);
      emit(DashboardLoaded(music));
    });

    on<PlayMusic>((event, emit) {
      onPlayMusic(data: event.musicResult);
    });
  }

  Future<Music?> getMusics({String? keyword}) async {
    Music? musics;
    musics = await DioClient().getMusic(keyword: keyword);
    return musics;
  }

  onPlayMusic({required Result data}) {
    //
  }
}
