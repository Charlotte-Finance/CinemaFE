import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String error;
  final Bloc bloc;
  final Equatable event;

  const ErrorMessage({
    Key? key,
    required this.error,
    required this.bloc,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(error),
        ElevatedButton(
          onPressed: () {
            bloc.add(event);
          },
          child: const Text("Try again"),
        )
      ],
    );
  }
}
