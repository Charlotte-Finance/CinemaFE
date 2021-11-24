import 'package:cinema_fe/pages/app_page.dart';
import 'package:cinema_fe/pages/form_page.dart';
import 'package:cinema_fe/pages/login_page.dart';
import 'package:cinema_fe/pages/movie_page.dart';
import 'package:cinema_fe/utils/route_arguments.dart';
import 'package:cinema_fe/utils/routing_constants.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    if (args is UserArgument) {
      switch (settings.name) {
        case LoginRoute:
          return _loginRoute(AppRoute);

        case AppRoute:
          return _appRoute(AppRoute, args);

        case MovieRoute:
          return _movieRoute(AppRoute, args);
        case FormRoute:
          return _formRoute(AppRoute, args);
        default:
          return _loginRoute(AppRoute);
      }
    } else {
      return _loginRoute(AppRoute);
    }
  }
}

Route<dynamic> _loginRoute(
  String route,
) {
  return PageRouteBuilder(
      settings: const RouteSettings(name: LoginRoute),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
      pageBuilder: (context, animation, secondaryAnimation) =>
          LoginPage(route: route));
}

Route<dynamic> _appRoute(String route, UserArgument args) {
  return PageRouteBuilder(
    settings: const RouteSettings(name: AppRoute),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
    pageBuilder: (context, animation, secondaryAnimation) => AppPage(
      user: args.user,
    ),
  );
}

Route<dynamic> _movieRoute(String route, UserArgument args) {
  if (args is MovieArgument) {
    return PageRouteBuilder(
      settings: const RouteSettings(name: AppRoute),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
      pageBuilder: (context, animation, secondaryAnimation) => MoviePage(
        user: args.user,
        movie: args.movie,
      ),
    );
  } else {
    return _loginRoute(AppRoute);
  }
}

Route<dynamic> _formRoute(String route, UserArgument args) {
  return PageRouteBuilder(
    settings: const RouteSettings(name: AppRoute),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
    pageBuilder: (context, animation, secondaryAnimation) => const FormPage(
    ),
  );
}
