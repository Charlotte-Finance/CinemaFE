import 'package:cinema_fe/blocs/movie_description/movie_description_bloc.dart';
import 'package:cinema_fe/blocs/tabs/liked_tab/liked_tab_bloc.dart';
import 'package:cinema_fe/components/widgets/error_message.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/utils/route_arguments.dart';
import 'package:cinema_fe/utils/routing_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'like_button.dart';

class MovieCard extends StatefulWidget {
  final Movie movie;
  final User user;
  final bool enableClick;
  final bool enableLike;
  final double? size;

  const MovieCard({
    Key? key,
    this.size,
    required this.user,
    required this.movie,
    this.enableClick = true,
    this.enableLike = true,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MovieCardState();
  }
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDescriptionBloc, MovieDescriptionState>(
      builder: (context, state) {
        if (state is MovieDescriptionEmpty) {
          context.watch<MovieDescriptionBloc>().add(
                FetchLike(
                  user: widget.user,
                  movie: widget.movie,
                ),
              );
        } else if (state is MovieDescriptionLoaded) {
          if (state is MovieDescriptionReloading) {
            context.watch<MovieDescriptionBloc>().add(
                  FetchLike(
                    user: widget.user,
                    movie: widget.movie,
                  ),
                );
          }
          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  if (widget.enableClick) {
                    Navigator.pushNamed(
                      context,
                      MovieRoute,
                      arguments: MovieArgument(
                        user: widget.user,
                        movie: widget.movie,
                      ),
                    );
                  }
                },
                child: Stack(
                  children: [
                    Image(
                      image: AssetImage(
                        'lib/assets/movies/${widget.movie.title}.jpg',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (widget.enableLike) {
                          BlocProvider.of<MovieDescriptionBloc>(context).add(
                            LikeMovie(
                              user: widget.user,
                              movie: widget.movie,
                              isLiked: (!widget.movie.isLiked!),
                            ),
                          );
                          BlocProvider.of<LikedTabBloc>(context).add(
                            ChangeLikedMovies(
                              movie: widget.movie,
                              isLiked: (!widget.movie.isLiked!),
                              user: widget.user,
                            ),
                          );
                        }
                      },
                      child: LikeButton(isLiked: widget.movie.isLiked!),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else if (state is MovieDescriptionError) {
          return ErrorMessage(
            error: state.error,
            bloc: BlocProvider.of<MovieDescriptionBloc>(context),
            event: state.event,
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
