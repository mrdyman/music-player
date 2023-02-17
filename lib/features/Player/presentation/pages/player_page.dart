import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_player/features/Player/presentation/bloc/player_bloc.dart';

import '../../../Dashboard/data/models/music_model.dart';

class PlayerPage extends StatelessWidget {
  final Result musicData;
  const PlayerPage({required this.musicData, super.key});

  @override
  Widget build(BuildContext context) {
    PlayerBloc bloc = BlocProvider.of<PlayerBloc>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Center(
          child: Text(
            'Now Playing',
            style: TextStyle(
                color: Colors.black87,
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(children: [
          Image.network(
            musicData.artworkUrl100,
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15)),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  children: [
                    Text(
                      musicData.trackName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Text(
                      musicData.artistName,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              BlocBuilder<PlayerBloc, PlayerState>(
                builder: (context, state) {
                  return Slider(
                      value: state is PlayerOnPlaying
                          ? state.progress
                          : state is PlayerOnPause
                              ? state.position
                              : 0.0,
                      onChanged: (value) => bloc.add(Seek(value)));
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<PlayerBloc, PlayerState>(
                      builder: (context, state) {
                        return Text(state is PlayerOnPlaying
                            ? "0${state.progress.toStringAsFixed(2)}"
                            : state is PlayerOnPause
                                ? "0${state.position.toStringAsFixed(2)}"
                                : "00.00");
                      },
                    ),
                    Text(((musicData.trackTimeMillis / 1000) / 60)
                        .toStringAsFixed(2)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => bloc.add(Backward()),
                      child: SvgPicture.asset(
                        "assets/images/seek-backward.svg",
                        width: 40,
                        height: 40,
                      ),
                    ),
                    const SizedBox(width: 10),
                    BlocBuilder<PlayerBloc, PlayerState>(
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            if (state is PlayerOnPlaying) {
                              bloc.add(Pause());
                            } else {
                              bloc.add(Play(musicData.previewUrl));
                            }
                          },
                          child: SvgPicture.asset(
                            state is PlayerOnPlaying
                                ? "assets/images/pause.svg"
                                : "assets/images/play.svg",
                            width: 40,
                            height: 40,
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => bloc.add(Forward()),
                      child: SvgPicture.asset(
                        "assets/images/seek-forward.svg",
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ],
                ),
              )
            ]),
          )
        ]),
      ),
    );
  }
}
