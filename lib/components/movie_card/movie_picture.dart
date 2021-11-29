import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/utils/image.dart';
import 'package:cinema_fe/utils/routes/route_arguments.dart';
import 'package:cinema_fe/utils/routes/routing_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'like_detector.dart';

class MoviePicture extends StatefulWidget {
  final Movie movie;
  final User user;
  final bool enableClick;
  final bool isLikedTab;

  const MoviePicture({
    Key? key,
    required this.user,
    required this.movie,
    this.enableClick = true,
    this.isLikedTab = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MoviePictureState();
  }
}

class _MoviePictureState extends State<MoviePicture> {
  @override
  Widget build(BuildContext context) {
    double width = widget.isLikedTab
        ? kIsWeb
            ? pictureWidth
            : MediaQuery.of(context).size.width * 0.5
        : pictureWidth;
    Image image = Image(
      image: AssetImage('lib/assets/movies/${widget.movie.title}.jpg'),
      width: width,
      height: pictureHeight,
      fit: BoxFit.fill,
    );
    return GestureDetector(
      onTap: () {
        if (widget.enableClick) {
          Navigator.pushNamed(
            context,
            movieRoute,
            arguments: MovieArgument(
              user: widget.user,
              movie: widget.movie,
            ),
          );
        }
      },
      child: Stack(
        children: [
          image,
          LikeDetector(
            user: widget.user,
            movie: widget.movie,
            enableClick: widget.enableClick,
            width: width * 0.15,
          ),
        ],
      ),
    );
  }
}
