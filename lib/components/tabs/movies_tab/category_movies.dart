import 'dart:collection';

import 'package:cinema_fe/models/category.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/utils/sizes.dart';
import 'package:cinema_fe/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/movie_card.dart';

class CategoryMovies extends StatelessWidget {
  final User user;
  final Category category;
  final HashMap movies;

  const CategoryMovies({
    Key? key,
    required this.user,
    required this.category,
    required this.movies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: categoryTitleHeight(context),
          padding: EdgeInsets.only(left: categoryLeftPadding(context)),
          alignment: Alignment.topLeft,
          child: Text(
            category.label,
            style: subtitleStyle,
          ),
        ),
        SizedBox(
          height: pictureHeight(context),
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: movies[category].length,
            itemBuilder: (ctx, movieIndex) {
              Movie movie = movies[category][movieIndex];
              return Container(
                padding: EdgeInsets.only(
                  left: picturesPadding(context),
                  right: picturesPadding(context),
                ),
                child: MovieCard(
                  user: user,
                  movie: movie,
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: categoryPadding(context),
        ),
      ],
    );
  }
}
