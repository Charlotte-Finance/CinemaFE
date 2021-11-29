import 'package:cinema_fe/pages/app_page.dart';
import 'package:cinema_fe/pages/form_page.dart';
import 'package:cinema_fe/pages/login_page.dart';
import 'package:cinema_fe/pages/movie_page.dart';
import 'package:cinema_fe/pages/user_page.dart';
import 'package:cinema_fe/utils/routes/route_arguments.dart';
import 'package:cinema_fe/utils/routes/routing_constants.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    if (args is UserArgument) {
      switch (settings.name) {
        case loginRoute:
          return _loginRoute(appRoute);

        case appRoute:
          return _appRoute(appRoute, args);

        case movieRoute:
          return _movieRoute(appRoute, args);

        case formRoute:
          return _formRoute(appRoute, args);

        case userRoute:
          return _userRoute(appRoute, args);

        default:
          return _loginRoute(appRoute);
      }
    } else {
      return _loginRoute(appRoute);
    }
  }
}

Route<dynamic> _loginRoute(
  String route,
) {
  return PageRouteBuilder(
      settings: const RouteSettings(name: loginRoute),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
      pageBuilder: (context, animation, secondaryAnimation) =>
          LoginPage(route: route));
}

Route<dynamic> _appRoute(String route, UserArgument args) {
  return PageRouteBuilder(
    settings: const RouteSettings(name: appRoute),
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
      settings: const RouteSettings(name: appRoute),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
      pageBuilder: (context, animation, secondaryAnimation) => MoviePage(
        user: args.user,
        movie: args.movie,
      ),
    );
  } else {
    return _loginRoute(appRoute);
  }
}

Route<dynamic> _formRoute(String route, UserArgument args) {
  return PageRouteBuilder(
    settings: const RouteSettings(name: appRoute),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
    pageBuilder: (context, animation, secondaryAnimation) => const FormPage(),
  );
}

Route<dynamic> _userRoute(String route, UserArgument args) {
  return PageRouteBuilder(
    settings: const RouteSettings(name: userRoute),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
    pageBuilder: (context, animation, secondaryAnimation) =>
        UserPage(user: args.user),
  );
}
