import 'package:flutter/material.dart';

void toast(BuildContext context, String message, bool succeed) {
  Color color = succeed ? Colors.green : Colors.red;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(40),
        ),
      ),
      backgroundColor: color,
      content: Text(
        message,
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
      duration: const Duration(seconds: 5),
    ),
  );
}
