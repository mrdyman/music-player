import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/features/Dashboard/presentation/bloc/dashboard_bloc.dart';
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
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(15),
                      color: Colors.grey[200]),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.search),
                  )),
            ]),
            const Padding(
              padding: EdgeInsets.only(top: 25, bottom: 15),
              child: Text('Tracks', style: TextStyle(fontSize: 15)),
            ),
            Expanded(
              child: BlocBuilder<DashboardBloc, DashboardState>(
                builder: (context, state) {
                  return state is DashboardLoaded &&
                          state.musics?.results != null
                      ? ListView.builder(
                          itemCount: state.musics?.results.length,
                          itemBuilder: (context, index) {
                            return musicCard(
                                state.musics!.results[index],
                                () => bloc.add(
                                    PlayMusic(state.musics!.results[index])));
                          })
                      : const CircularProgressIndicator();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
