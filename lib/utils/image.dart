
import 'package:flutter/cupertino.dart';


Image formatImage(String path) {
  return Image(
    height: 420,
    width: 310,
    image: AssetImage(path),
    fit: BoxFit.fitHeight,
  );
}

double pictureHeight = 420;
double pictureWidth = 310;
