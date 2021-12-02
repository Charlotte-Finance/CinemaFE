import 'package:cinema_fe/components/movie_description/entity_list.dart';
import 'package:cinema_fe/models/director.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/utils/image.dart';
import 'package:cinema_fe/utils/styles/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DirectorDescription extends StatelessWidget {
  final User user;
  final Director director;
  final List<Movie> movies;

  const DirectorDescription({
    Key? key,
    required this.user,
    required this.director,
    required this.movies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text("${director.firstname} ${director.name}", style: movieTitleStyle),
              const SizedBox(
                height: 10,
              ),
              Image(
                image: AssetImage(
                    'lib/assets/directors/${director.firstname} ${director.name}.jpg'),
                width: pictureWidth,
                height: pictureHeight,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
        EntityList(
          user: user,
          entities: movies,
          isEditable: false,
        ),
      ],
    );
  }
}
