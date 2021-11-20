import 'package:cinema_fe/pages/login_page.dart';
import 'package:cinema_fe/utils/route_generator.dart';
import 'package:cinema_fe/utils/routing_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_strategy/url_strategy.dart';

import 'blocs/add_tab/add_tab_bloc.dart';
import 'blocs/liked_tab/liked_tab_bloc.dart';
import 'blocs/login_page/login_bloc.dart';
import 'blocs/movies_tab/movies_tab_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
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
        BlocProvider<MoviesTabBloc>(
          create: (BuildContext context) => MoviesTabBloc(),
        ),
        BlocProvider<LikedTabBloc>(
          create: (BuildContext context) => LikedTabBloc(),
        ),
        BlocProvider<AddTabBloc>(
          create: (BuildContext context) => AddTabBloc(),
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
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.cyan,
          ),
        ),
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      onGenerateInitialRoutes: (route) {
        return [
          PageRouteBuilder(
            settings: const RouteSettings(name: LoginRoute),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return child;
            },
            pageBuilder: (context, animation, secondaryAnimation) =>
                const LoginPage(route: AppRoute),
          ),
        ];
      },
    );
  }
}
