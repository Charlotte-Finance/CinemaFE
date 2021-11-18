import 'package:cinema_fe/blocs/more/more_bloc.dart';
import 'package:cinema_fe/components/error_message.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MorePage extends StatelessWidget {
  final User? user;

  const MorePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoreBloc, MoreState>(
      builder: (context, state) {
        if (state is MoreLoaded) {
          return Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  context.watch<MoreBloc>().add(GetMovieForm());
                },
                child: const Text("Add a movie"),
              ),
              ElevatedButton(
                onPressed: () {
                  context.watch<MoreBloc>().add(GetActorForm());
                },
                child: const Text("Add an actor"),
              ),
              ElevatedButton(
                onPressed: () {
                  context.watch<MoreBloc>().add(GetCharacterForm());
                },
                child: const Text("Add a character"),
              ),
            ],
          );
        } else if (state is MoreError) {
          return ErrorMessage(
            error: state.error,
            bloc: BlocProvider.of<MoreBloc>(context),
            event: state.event,
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
