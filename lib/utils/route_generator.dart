import 'package:cinema_fe/pages/app_page.dart';
import 'package:cinema_fe/pages/login_page.dart';
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
          return PageRouteBuilder(
            settings: const RouteSettings(name: AppRoute),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return child;
            },
            pageBuilder: (context, animation, secondaryAnimation) => AppPage(
              user: args.user,
            ),
          );

        default:
          return _loginRoute(AppRoute);
      }
    } else {
      return _loginRoute(AppRoute);
    }
  }
}

Route<dynamic> _loginRoute(String route) {
  return PageRouteBuilder(
      settings: const RouteSettings(name: LoginRoute),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
      pageBuilder: (context, animation, secondaryAnimation) =>
          LoginPage(route: route));
}
