import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

double carrouselHeight(BuildContext context) {
  double size = kIsWeb
      ? MediaQuery.of(context).size.height * 0.46
      : MediaQuery.of(context).size.height * 0.46;
  return size;
}



double titleHeight(BuildContext context) {
  double size = kIsWeb
      ? MediaQuery.of(context).size.height * 0.1
      : MediaQuery.of(context).size.height * 0.1;
  return size;
}





double iconContainerSize(BuildContext context) {
  double size = kIsWeb
      ? MediaQuery.of(context).size.height * 0.06
      : MediaQuery.of(context).size.height * 0.06;
  return size;
}
