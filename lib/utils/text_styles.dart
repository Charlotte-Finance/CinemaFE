import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

TextStyle errorStyle = const TextStyle(color: Colors.red);

TextStyle addSectionBorderStyle = TextStyle(
  fontSize: 40,
  foreground: Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1
    ..color = Colors.black,
);

TextStyle addSectionStyle = const TextStyle(
  fontSize: 40,
  color: Colors.orange,
);

TextStyle subtitleStyle = const TextStyle(
  fontSize: 30,
  color: Colors.orange,
);
TextStyle movieTitleStyle = const TextStyle(
  fontSize: 30,
  color: Colors.orange,
);
TextStyle movieSubtitleStyle = const TextStyle(
  fontSize: 20,
);

TextStyle categoryStyle = const TextStyle(
  fontSize: 20,
  color: Colors.orange,
);