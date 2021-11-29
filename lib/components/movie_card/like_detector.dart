import 'package:cinema_fe/blocs/liked_tab/liked_tab_bloc.dart';
import 'package:cinema_fe/blocs/movie_card/movie_card_bloc.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'like_button.dart';

class LikeDetector extends StatefulWidget {
  final Movie movie;
  final User user;
  final bool enableClick;
  final double width;

  const LikeDetector({
    Key? key,
    required this.user,
    required this.movie,
    required this.width,
    this.enableClick = true,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LikeDetectorState();
  }
}

class _LikeDetectorState extends State<LikeDetector> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                      },
                      child: const Text('Close')),
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
        } else {
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
      child: LikeButton(
        isLiked: widget.movie.isLiked!,
        width: widget.width,
      ),
    );
  }
}
