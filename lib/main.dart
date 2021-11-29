import 'dart:ui';

import 'package:cinema_fe/pages/login_page.dart';
import 'package:cinema_fe/utils/routes/route_generator.dart';
import 'package:cinema_fe/utils/routes/routing_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_strategy/url_strategy.dart';

import 'blocs/forms/actor/actor_bloc.dart';
import 'blocs/forms/character/character_bloc.dart';
import 'blocs/forms/director/director_bloc.dart';
import 'blocs/forms/forms_bloc.dart';
import 'blocs/forms/movie/movie_bloc.dart';
import 'blocs/liked_tab/liked_tab_bloc.dart';
import 'blocs/login/login_bloc.dart';
import 'blocs/movie_card/movie_card_bloc.dart';
import 'blocs/movie_description/movie_description_bloc.dart';
import 'blocs/movies_tab/movies_tab_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    //print(transition);
  }
}

void main() {
  setPathUrlStrategy();
  Bloc.observer = AppBlocObserver();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (BuildContext context) => LoginBloc(),
        ),
        BlocProvider<FormsBloc>(
          create: (BuildContext context) => FormsBloc(),
        ),
        BlocProvider<MovieDescriptionBloc>(
          create: (BuildContext context) => MovieDescriptionBloc(),
        ),
        BlocProvider<MovieCardBloc>(
          create: (BuildContext context) => MovieCardBloc(),
        ),
        BlocProvider<MovieBloc>(
          create: (BuildContext context) => MovieBloc(),
        ),
        BlocProvider<CharacterBloc>(
          create: (BuildContext context) => CharacterBloc(),
        ),
        BlocProvider<ActorBloc>(
          create: (BuildContext context) => ActorBloc(),
        ),
        BlocProvider<DirectorBloc>(
          create: (BuildContext context) => DirectorBloc(),
        ),
        BlocProvider<MoviesTabBloc>(
          create: (BuildContext context) => MoviesTabBloc(),
        ),
        BlocProvider<LikedTabBloc>(
          create: (BuildContext context) => LikedTabBloc(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.orange,
        primarySwatch: Colors.orange,
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      onGenerateInitialRoutes: (route) {
        return [
          PageRouteBuilder(
            settings: const RouteSettings(name: loginRoute),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return child;
            },
            pageBuilder: (context, animation, secondaryAnimation) =>
                const LoginPage(route: appRoute),
          ),
        ];
      },
    );
  }
}
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}