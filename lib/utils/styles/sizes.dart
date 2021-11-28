import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


double iconSize(BuildContext context) {
  double size = kIsWeb
      ? MediaQuery.of(context).size.height * 0.05
      : MediaQuery.of(context).size.height * 0.05;
  return size;
}
