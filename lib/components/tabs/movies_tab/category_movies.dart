import 'dart:collection';

import 'package:cinema_fe/models/category.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';

import 'movie_card.dart';

class CategoryMovies extends StatelessWidget {
  final User user;
  final HashMap movies;

  const CategoryMovies({
    Key? key,
    required this.user,
    required this.movies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: movies.keys.length,
      itemBuilder: (ctx, indexCategory) {
        Category category = movies.keys.elementAt(indexCategory);
        return Column(
          children: [
            const SizedBox(height: 50),
            Container(
              padding: const EdgeInsets.only(left: 30.0),
              alignment: Alignment.centerLeft,
              child: Text(
                category.label,
                style: subtitleStyle,
              ),
            ),
            SizedBox(
              height: 400,
              width: 10000,
              child: ListView.builder(
                shrinkWrap: false,
                scrollDirection: Axis.horizontal,
                itemCount: movies[category].length,
                itemBuilder: (ctx, movieIndex) {
                  Movie movie = movies[category][movieIndex];
                  return Container(
                    padding: const EdgeInsets.all(10.0),
                    child: MovieCard(
                      user: user,
                      movie: movie,
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
