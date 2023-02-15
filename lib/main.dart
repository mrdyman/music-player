import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:music_player/features/Dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/Dashboard/presentation/pages/dashboard_page.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<DashboardBloc>(
        create: (context) => DashboardBloc(),
        child: const DashboardPage(),
      ),
    );
  }
}
