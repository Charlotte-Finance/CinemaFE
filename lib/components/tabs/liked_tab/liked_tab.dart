import 'package:cinema_fe/blocs/tabs/liked_tab/liked_tab_bloc.dart';
import 'package:cinema_fe/components/tabs/liked_tab/liked_movies.dart';
import 'package:cinema_fe/components/widgets/error_message.dart';
import 'package:cinema_fe/components/widgets/movie_card.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LikedTab extends StatelessWidget {
  final User user;

  const LikedTab({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LikedTabBloc, LikedTabState>(
      builder: (context, state) {
        if (state is LikedTabEmpty) {
          context.watch<LikedTabBloc>().add(GetLikedMovies(user: user));
        } else if (state is LikedTabLoaded) {
          if (state is LikedTabReloading) {
            context.watch<LikedTabBloc>().add(GetLikedMovies(user: user));
          }
          return LikedMovies(user: user, movies: state.movies);
        } else if (state is LikedTabError) {
          return ErrorMessage(
            error: state.error,
            bloc: BlocProvider.of<LikedTabBloc>(context),
            event: state.event,
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
