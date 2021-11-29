import 'dart:async';
import 'dart:ui' as ui;

import 'package:cinema_fe/blocs/movie_card/movie_card_bloc.dart';
import 'package:cinema_fe/blocs/tabs/liked_tab/liked_tab_bloc.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/utils/routes/route_arguments.dart';
import 'package:cinema_fe/utils/routes/routing_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'like_button.dart';
import 'like_detector.dart';

class MoviePicture extends StatefulWidget {
  final Movie movie;
  final User user;
  final bool enableClick;

  const MoviePicture({
    Key? key,
    required this.user,
    required this.movie,
    this.enableClick = true,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MoviePictureState();
  }
}

class _MoviePictureState extends State<MoviePicture> {
  @override
  Widget build(BuildContext context) {
    Image image = Image(
      image: AssetImage('lib/assets/movies/${widget.movie.title}.jpg'),
    );
    Completer<ui.Image> completer = Completer<ui.Image>();
    image.image
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      completer.complete(info.image);
    }));

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
      child: Stack(
        children: [
          kIsWeb ? image : SizedBox(width: MediaQuery
              .of(context)
              .size
              .width * 0.5, child: image,
              ),
          FutureBuilder<ui.Image>(
            future: completer.future,
            builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
              if (snapshot.hasData) {
                return LikeDetector(
                  user: widget.user,
                  movie: widget.movie,
                  enableClick: widget.enableClick,
                  width: snapshot.data!.width * 0.15,
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
