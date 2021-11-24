import 'package:cinema_fe/blocs/movie/movie_bloc.dart';
import 'package:cinema_fe/blocs/tabs/liked_tab/liked_tab_bloc.dart';
import 'package:cinema_fe/components/widgets/error_message.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/utils/route_arguments.dart';
import 'package:cinema_fe/utils/routing_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final User user;

  final Icon unlikedIcon = const Icon(
    Icons.favorite_border,
    color: Colors.red,
    size: 40,
  );
  final Icon likedIcon = const Icon(
    Icons.favorite,
    color: Colors.red,
    size: 40,
  );

  const MovieCard({
    Key? key,
    required this.user,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieBloc, MovieState>(
      listener: (context, state) {
        if (state is MovieLoading) {}
        BlocProvider.of<LikedTabBloc>(context).add(Refresh());
      },
      builder: (context, state) {
        if (state is MovieEmpty) {
          context.watch<MovieBloc>().add(
                FetchLike(
                  user: user,
                  movie: movie,
                ),
              );
        } else if (state is MovieLoaded) {
          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  WidgetsBinding.instance!.addPostFrameCallback(
                    (_) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        MovieRoute,
                        ModalRoute.withName(MovieRoute),
                        arguments: MovieArgument(user: user, movie: movie),
                      );
                    },
                  );
                },
                child: Image(
                  image: AssetImage('lib/assets/movies/${movie.title}.jpg'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  BlocProvider.of<MovieBloc>(context).add(
                    LikeMovie(
                      user: user,
                      movie: movie,
                      isLiked: !(movie.isLiked!),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  color: Colors.white.withOpacity(0.2),
                  child: movie.isLiked! ? likedIcon : unlikedIcon,
                ),
              ),
            ],
          );
        } else if (state is MovieError) {
          return ErrorMessage(
            error: state.error,
            bloc: BlocProvider.of<MovieBloc>(context),
            event: state.event,
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
