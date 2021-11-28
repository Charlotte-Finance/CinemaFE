import 'dart:collection';

import 'package:cinema_fe/models/category.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/utils/styles/sizes/movies.dart';
import 'package:cinema_fe/utils/styles/text_styles.dart';
import 'package:cinema_fe/utils/styles/texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'category_movies.dart';
import 'movies_carousel.dart';

class MoviesTabContent extends StatelessWidget {
  final User user;
  final HashMap movies;

  const MoviesTabContent({
    Key? key,
    required this.user,
    required this.movies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Movie> allMovies = [];
    for (List<Movie> movies in movies.values) {
      for (Movie movie in movies) {
        allMovies.add(movie);
      }
    }
    return Column(
      children: [
        SizedBox(
          height: titleHeight(context),
          child: Center(
            child: Text(
              moviesTabTitleStr,
              style: subtitleStyle,
            ),
          ),
        ),
        MoviesCarousel(
          user: user,
          movies: movies,
          allMovies: allMovies,
        ),
        SizedBox(
          height: titleHeight(context),
        ),
        for (Category category in movies.keys) ...[
          CategoryMovies(
            user: user,
            category: category,
            movies: movies,
          ),
        ],
      ],
    );
  }
}
