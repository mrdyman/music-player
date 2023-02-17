import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/features/Dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:music_player/features/Player/presentation/bloc/player_bloc.dart';
import 'package:music_player/features/Player/presentation/pages/player_page.dart';
import '../widgets/music_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardBloc bloc = BlocProvider.of<DashboardBloc>(context);
    bloc.add(GetMusics());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Welcome back,',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  Text('Dyman',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                ],
              ),
            ]),
            const SizedBox(height: 20),
            TextFormField(
              textInputAction: TextInputAction.done,
              onChanged: null,
              decoration: InputDecoration(
                hintText: "eg. Maroon 5",
                errorStyle: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
                helperMaxLines: 2,
                hintStyle: TextStyle(color: Theme.of(context).hintColor),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                constraints: const BoxConstraints(maxHeight: double.infinity),
                suffixIcon: const Padding(
                  padding: EdgeInsets.only(right: 18),
                  child: Icon(Icons.search),
                ),
                suffixIconConstraints: const BoxConstraints(
                  minHeight: 12,
                  minWidth: 12,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor.withAlpha(0),
                  ),
                ),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 25, bottom: 15),
              child: Text('Tracks', style: TextStyle(fontSize: 15)),
            ),
            Expanded(
              child: BlocBuilder<DashboardBloc, DashboardState>(
                builder: (context, state) {
                  return state is DashboardLoaded &&
                          state.musics?.results != null
                      ? RefreshIndicator(
                          onRefresh: () async => bloc.add(GetMusics()),
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: state.musics?.results.length,
                              itemBuilder: (context, index) {
                                return musicCard(
                                    state.musics!.results[index],
                                    () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BlocProvider<PlayerBloc>(
                                                  create: (context) =>
                                                      PlayerBloc(),
                                                  child: PlayerPage(
                                                      musicData: state.musics!
                                                          .results[index]),
                                                ))));
                              }),
                        )
                      : const Center(child: CircularProgressIndicator());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
