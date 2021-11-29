import 'dart:collection';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinema_fe/components/movie_card/movie_card.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class MoviesCarousel extends StatelessWidget {
  final User user;
  final HashMap movies;
  final List<Movie> allMovies;

  const MoviesCarousel({
    Key? key,
    required this.allMovies,
    required this.movies,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.46,
        aspectRatio: 16 / 9,
        viewportFraction: kIsWeb ? 0.1 : 0.6,
        initialPage: 0,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        enlargeCenterPage: true,
      ),
      items: allMovies.map((movie) {
        return Builder(
          builder: (BuildContext context) {
            return MovieCard(
              user: user,
              movie: movie,
            );
          },
        );
      }).toList(),
    );
  }
}
