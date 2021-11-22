import 'dart:collection';

import 'package:cinema_fe/blocs/movies_tab/movies_tab_bloc.dart';
import 'package:cinema_fe/models/actor.dart';
import 'package:cinema_fe/models/director.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class DirectorList extends StatelessWidget {
  final HashMap movies;
  final Movie movie;
  final List<Director> directors;

  const DirectorList({
    Key? key,
    required this.movies,
    required this.movie,
    required this.directors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        Container(
          padding: const EdgeInsets.only(left: 30.0),
          alignment: Alignment.centerLeft,
          child: Text(
            "Directors",
            style: subtitleStyle,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: 10000,
          height: 500,
          child: ListView.builder(
            shrinkWrap: false,
            scrollDirection: Axis.horizontal,
            itemCount: directors.length,
            itemBuilder: (ctx, index) {
              return SizedBox(
                height: 500,
                child: Column(
                  children: [
                    Container(
                      height: 400,
                      width: 350,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'lib/assets/directors/${directors[index].id}.jpg',
                          ),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 350,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.create_rounded),
                            onPressed: () {
                              Provider.of<MoviesTabBloc>(context, listen: false)
                                  .add(
                                FetchDirectorForm(
                                    movies: movies, director: directors[index], movie:movie),
                              );
                            },
                          ),
                          Text(
                            directors[index].firstname! + " " +
                                directors[index].name!,
                            style: const TextStyle(fontSize: 20),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              Provider.of<MoviesTabBloc>(context, listen: false)
                                  .add(
                                DeleteDirector(director: directors[index]),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
