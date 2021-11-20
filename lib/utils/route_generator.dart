import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poc_front/blocs/creation/creation_bloc.dart';
import 'package:poc_front/blocs/declaration/declaration_bloc.dart';
import 'package:poc_front/blocs/home_page/my_projects/my_projects_bloc.dart';
import 'package:poc_front/blocs/reporting/reporting_bloc.dart';
import 'package:poc_front/blocs/validation/validation_bloc.dart';
import 'package:poc_front/models/route_arguments/creation_route_arguments.dart';
import 'package:poc_front/models/route_arguments/declaration_route_arguments.dart';
import 'package:poc_front/models/route_arguments/reporting_route_arguments.dart';
import 'package:poc_front/models/route_arguments/user_arguments.dart';
import 'package:poc_front/models/route_arguments/validation_route_arguments.dart';
import 'package:poc_front/models/user.dart';
import 'package:poc_front/pages/creation_page.dart';
import 'package:poc_front/pages/creation_page_completed.dart';
import 'package:poc_front/pages/declaration_page.dart';
import 'package:poc_front/pages/home_page/about.dart';
import 'package:poc_front/pages/home_page/contact.dart';
import 'package:poc_front/pages/home_page/home_page.dart';
import 'package:poc_front/pages/home_page/my_projects.dart';
import 'package:poc_front/pages/login_page.dart';
import 'package:poc_front/pages/reporting_page.dart';
import 'package:poc_front/pages/validation_page.dart';
import 'package:poc_front/utils/routing_constants.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    if (args is UserArgument) {
      switch (settings.name) {
        case LoginRoute:
          return _loginRoute(HomeRoute);

        case HomeRoute:
          return PageRouteBuilder(
            settings: RouteSettings(name: HomeRoute),
            transitionDuration: Duration(seconds: 0),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return child;
            },
            pageBuilder: (context, animation, secondaryAnimation) => HomePage(
              user: args.user,
            ),
          );
        case MyProjectsRoute:
          return PageRouteBuilder(
            settings: RouteSettings(name: MyProjectsRoute),
            transitionDuration: Duration(seconds: 0),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return child;
            },
            pageBuilder: (context, animation, secondaryAnimation) =>
                BlocProvider(
              create: (BuildContext context) => MyProjectsBloc(),
              child: MyProjectsPage(user: args.user),
            ),
          );

        case AboutRoute:
          return PageRouteBuilder(
            settings: RouteSettings(name: AboutRoute),
            transitionDuration: Duration(seconds: 0),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return child;
            },
            pageBuilder: (context, animation, secondaryAnimation) => AboutPage(
              user: args.user,
            ),
          );

        case ContactRoute:
          return MaterialPageRoute(
            settings: RouteSettings(name: ContactRoute),
            builder: (_) => ContactPage(
              user: args.user,
            ),
          );

        case CreationRoute:
          if (args is UserArgument) {
            return PageRouteBuilder(
              settings: RouteSettings(name: CreationRoute),
              transitionDuration: Duration(seconds: 0),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child;
              },
              pageBuilder: (context, animation, secondaryAnimation) =>
                  BlocProvider(
                create: (BuildContext context) => CreationBloc(),
                child: CreationPage(
                  user: args.user,
                ),
              ),
            );
          } else if (args is CreationRouteArguments) {
            return PageRouteBuilder(
              settings: RouteSettings(
                  name: "/" + args.project.projectAcronym! + CreationRoute),
              transitionDuration: Duration(seconds: 0),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child;
              },
              pageBuilder: (context, animation, secondaryAnimation) =>
                  BlocProvider(
                create: (BuildContext context) => CreationBloc(),
                child: CreationPageCompleted(
                  user: args.user,
                  project: args.project,
                ),
              ),
            );
          } else
            return _loginRoute(CreationRoute);

        case DeclarationRoute:
          if (args is DeclarationRouteArguments) {
            return PageRouteBuilder(
              settings: RouteSettings(
                  name: "/" + args.project.projectAcronym! + DeclarationRoute),
              transitionDuration: Duration(seconds: 0),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child;
              },
              pageBuilder: (context, animation, secondaryAnimation) =>
                  BlocProvider(
                create: (BuildContext context) => DeclarationBloc(),
                child: DeclarationPage(
                  user: args.user,
                  project: args.project,
                ),
              ),
            );
          } else
            return _loginRoute(DeclarationRoute);

        case ValidationRoute:
          if (args is ValidationRouteArguments) {
            return PageRouteBuilder(
              settings: RouteSettings(
                  name: "/" + args.project.projectAcronym! + ValidationRoute),
              transitionDuration: Duration(seconds: 0),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child;
              },
              pageBuilder: (context, animation, secondaryAnimation) =>
                  BlocProvider(
                create: (BuildContext context) => ValidationBloc(),
                child: ValidationPage(
                  user: args.user,
                  project: args.project,
                ),
              ),
            );
          } else
            return _loginRoute(ValidationRoute);

        case ReportingRoute:
          if (args is ReportingRouteArguments) {
            return PageRouteBuilder(
              settings: RouteSettings(
                  name: "/" + args.project.projectAcronym! + ReportingRoute),
              transitionDuration: Duration(seconds: 0),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child;
              },
              pageBuilder: (context, animation, secondaryAnimation) =>
                  BlocProvider(
                create: (BuildContext context) => ReportingBloc(),
                child: ReportingPage(
                  user: args.user,
                  project: args.project,
                ),
              ),
            );
          } else
            return _loginRoute(ReportingRoute);

        default:
          return _loginRoute(HomeRoute);
      }
    } else {
      return _loginRoute(HomeRoute);
    }
  }
}

Route<dynamic> _loginRoute(String route) {
  return PageRouteBuilder(
      settings: RouteSettings(name: LoginRoute),
      transitionDuration: Duration(seconds: 0),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
      pageBuilder: (context, animation, secondaryAnimation) =>
          LoginPage(route: route));
}
