import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
