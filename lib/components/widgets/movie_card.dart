import 'package:cinema_fe/blocs/movie_card/movie_card_bloc.dart';
import 'package:cinema_fe/blocs/tabs/liked_tab/liked_tab_bloc.dart';
import 'package:cinema_fe/components/widgets/error_message.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/utils/routes/route_arguments.dart';
import 'package:cinema_fe/utils/routes/routing_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'like_button.dart';

class MovieCard extends StatefulWidget {
  final Movie movie;
  final User user;
  final bool enableClick;
  final double width;

  const MovieCard({
    Key? key,
    required this.user,
    required this.movie,
    this.enableClick = true,
    required this.width,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MovieCardState();
  }
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCardBloc, MovieCardState>(
      builder: (context, state) {
        if (state is MovieCardEmpty) {
          context.watch<MovieCardBloc>().add(
                FetchLike(
                  user: widget.user,
                  movie: widget.movie,
                ),
              );
        } else if (state is MovieCardLoaded) {
          if (state is MovieCardReloading &&
              state.movie.id == widget.movie.id!) {
            context.watch<MovieCardBloc>().add(
                  FetchLike(
                    user: widget.user,
                    movie: widget.movie,
                  ),
                );
          }
          return GestureDetector(
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
            child: Container(
              width: widget.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:
                      AssetImage('lib/assets/movies/${widget.movie.title}.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              alignment: Alignment.topLeft,
              child: SizedBox(
                height: widget.width * 0.18,
                width: widget.width * 0.18,
                child: GestureDetector(
                  onTap: () {
                    if (widget.movie.isLiked!) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Unlike this movie ?'),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }, child: const Text('Close')),
                              TextButton(
                                onPressed: () {
                                  BlocProvider.of<MovieCardBloc>(context).add(
                                    LikeMovie(
                                      user: widget.user,
                                      movie: widget.movie,
                                      isLiked: (!widget.movie.isLiked!),
                                    ),
                                  );
                                  // ToDo: Bloc listener ?
                                  BlocProvider.of<LikedTabBloc>(context).add(
                                    ChangeLikedMovies(
                                      movie: widget.movie,
                                      isLiked: (!widget.movie.isLiked!),
                                      user: widget.user,
                                    ),
                                  );
                                  Navigator.pop(context);

                                },
                                child: const Text('Unlike!'),
                              )
                            ],
                          );
                        },
                      );
                    }else {
                      BlocProvider.of<MovieCardBloc>(context).add(
                        LikeMovie(
                          user: widget.user,
                          movie: widget.movie,
                          isLiked: (!widget.movie.isLiked!),
                        ),
                      );
                      // ToDo: Bloc listener ?
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
              ),
            ),
          );
        } else if (state is MovieCardError) {
          return ErrorMessage(
            error: state.error,
            bloc: BlocProvider.of<MovieCardBloc>(context),
            event: state.event,
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
