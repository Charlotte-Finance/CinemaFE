import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

double carrouselHeight(BuildContext context) {
  double size = kIsWeb
      ? MediaQuery.of(context).size.height * 0.46
      : MediaQuery.of(context).size.height * 0.46;
  return size;
}

double pictureHeight(BuildContext context) {
  double size = kIsWeb
      ? MediaQuery.of(context).size.height * 0.40
      : MediaQuery.of(context).size.height * 0.40;
  return size;
}

double titleHeight(BuildContext context) {
  double size = kIsWeb
      ? MediaQuery.of(context).size.height * 0.1
      : MediaQuery.of(context).size.height * 0.1;
  return size;
}

double categoryPadding(BuildContext context) {
  double size = kIsWeb
      ? MediaQuery.of(context).size.height * 0.075
      : MediaQuery.of(context).size.height * 0.075;
  return size;
}

double categoryTitleHeight(BuildContext context) {
  double size = kIsWeb ? 60.0 : 60.0;
  return size;
}

double categoryLeftPadding(BuildContext context) {
  double size = kIsWeb ? 30.0 : 30.0;
  return size;
}

double picturesPadding(BuildContext context) {
  double size = kIsWeb ? 10.0 : 10.0;
  return size;
}

double iconContainerSize = 75.0;
double iconSize = 40.0;