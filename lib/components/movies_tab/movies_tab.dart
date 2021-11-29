import 'package:cinema_fe/blocs/movies_tab/movies_tab_bloc.dart';
import 'package:cinema_fe/components/widgets/error_message.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'movies_tab_content.dart';

class MoviesTab extends StatelessWidget {
  final User user;

  const MoviesTab({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesTabBloc, MoviesTabState>(
      builder: (context, state) {
        if (state is MoviesTabEmpty) {
          context.watch<MoviesTabBloc>().add(GetMovies());
        } else if (state is MoviesTabLoaded) {
          return MoviesTabContent(
            user: user,
            movies: state.movies,
          );
        } else if (state is MoviesTabError) {
          return ErrorMessage(
            error: state.error,
            bloc: BlocProvider.of<MoviesTabBloc>(context),
            event: state.event,
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
