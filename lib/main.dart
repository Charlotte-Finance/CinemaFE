import 'package:cinema_fe/pages/page_structure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/home_page/home_page_bloc.dart';
import 'blocs/more/more_bloc.dart';
import 'blocs/my_favourites/my_favourites_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<HomePageBloc>(
          create: (BuildContext context) => HomePageBloc(),
        ),
        BlocProvider<MyFavouritesBloc>(
          create: (BuildContext context) => MyFavouritesBloc(),
        ),
        BlocProvider<MoreBloc>(
          create: (BuildContext context) => MoreBloc(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.cyan,
          ),
        ),
      ),
      home: const PageStructure(title: 'Flutter Demo Home Page'),
    );
  }
}
