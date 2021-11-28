import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

double favoriteMovieHeight(BuildContext context) {
  double size = kIsWeb
      ? MediaQuery.of(context).size.height * 0.3
      : MediaQuery.of(context).size.height * 0.3;
  return size;
}

double favoriteMovieWidth(BuildContext context) {
  double size = kIsWeb
      ? MediaQuery.of(context).size.width * 0.3
      : MediaQuery.of(context).size.width * 0.3;
  return size;
}
