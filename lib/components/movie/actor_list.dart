import 'dart:collection';

import 'package:cinema_fe/blocs/movies_tab/movies_tab_bloc.dart';
import 'package:cinema_fe/models/actor.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class ActorList extends StatelessWidget {
  final HashMap movies;
  final Movie movie;
  final List<Actor> actors;

  const ActorList({
    Key? key,
    required this.movies,
    required this.movie,
    required this.actors,
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
            "Actors",
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
            itemCount: actors.length,
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
                            'lib/assets/actors/${actors[index].id}.jpg',
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
                                FetchActorForm(
                                    movies: movies, movie:movie,actor: actors[index]),
                              );
                            },
                          ),
                          Text(
                            actors[index].firstname! + " " + actors[index].name!,
                            style: const TextStyle(fontSize: 20),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              Provider.of<MoviesTabBloc>(context, listen: false)
                                  .add(
                                DeleteActor(actor: actors[index]),
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
