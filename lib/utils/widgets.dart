import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

IconButton backLeading(BuildContext context, String route, Object? arguments) {
  return IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () => Navigator.pushNamedAndRemoveUntil(
      context,
      route,
      ModalRoute.withName(route),
      arguments: arguments,
    ),
  );
}
