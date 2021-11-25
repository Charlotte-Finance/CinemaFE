
import 'dart:collection';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:flutter/cupertino.dart';

import '../../widgets/movie_card.dart';

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
        height: 400,
        aspectRatio: 16 / 9,
        viewportFraction: 0.6,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration:
        const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: false,
        scrollDirection: Axis.horizontal,
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
