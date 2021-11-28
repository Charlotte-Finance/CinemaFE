import 'dart:collection';

import 'package:cinema_fe/models/category.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/utils/styles/text_styles.dart';
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
          height: MediaQuery.of(context).size.height * 0.045,
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.035),
          alignment: Alignment.topLeft,
          child: Text(
            category.label,
            style: subtitleStyle,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.40,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: movies[category].length,
            itemBuilder: (ctx, movieIndex) {
              Movie movie = movies[category][movieIndex];
              return Container(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                ),
                child: MovieCard(
                  user: user,
                  movie: movie,
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.065,
        ),
      ],
    );
  }
}
