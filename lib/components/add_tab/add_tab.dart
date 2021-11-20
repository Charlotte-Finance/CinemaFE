import 'package:cinema_fe/blocs/add_tab/add_tab_bloc.dart';
import 'package:cinema_fe/components/error_message.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTab extends StatelessWidget {
  final User user;

  const AddTab({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTabBloc, AddTabState>(
      builder: (context, state) {
        if (state is AddTabLoaded) {
          return Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.red,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.blue,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.green,
                ),
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     context.watch<AddTabBloc>().add(GetMovieForm());
              //   },
              //   child: const Text("Add a movie"),
              // ),
              // ElevatedButton(
              //   onPressed: () {
              //     context.watch<AddTabBloc>().add(GetActorForm());
              //   },
              //   child: const Text("Add an actor"),
              // ),
              // ElevatedButton(
              //   onPressed: () {
              //     context.watch<AddTabBloc>().add(GetCharacterForm());
              //   },
              //   child: const Text("Add a character"),
              // ),
            ],
          );
        } else if (state is AddTabError) {
          return ErrorMessage(
            error: state.error,
            bloc: BlocProvider.of<AddTabBloc>(context),
            event: state.event,
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
