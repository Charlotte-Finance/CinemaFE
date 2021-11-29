import 'package:cinema_fe/blocs/forms/forms_bloc.dart';
import 'package:cinema_fe/blocs/forms/movie/movie_bloc.dart';
import 'package:cinema_fe/components/movie_card/movie_card.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/utils/routes/route_arguments.dart';
import 'package:cinema_fe/utils/routes/routing_constants.dart';
import 'package:cinema_fe/utils/styles/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'entity_list.dart';

class MovieDescription extends StatelessWidget {
  final User user;
  final Movie movie;

  const MovieDescription({
    Key? key,
    required this.user,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(movie.title!, style: movieTitleStyle),
              const SizedBox(
                height: 10,
              ),
              Text(
                "A movie from ${movie.director!.firstname} ${movie.director!.name}",
                style: movieSubtitleStyle,
              ),
              Text(
                movie.category!.label,
                style: categoryStyle,
              ),
            ],
          ),
        ),
        MovieCard(
          user: user,
          movie: movie,
          enableClick: false,
        ),
        EntityList(
          user: user,
          entities: movie.characters!,
          isDeletable: true,
        ),
        EntityList(
          user: user,
          entities: movie.characters!,
          isActor: true,
        ),
        EntityList(
          user: user,
          entities: [movie.director!],
        ),
        ElevatedButton(
          onPressed: () {
            BlocProvider.of<FormsBloc>(context).add(
              GetMovieForm(movie: movie),
            );
            Navigator.pushNamed(
              context,
              formRoute,
              arguments: UserArgument(user: user),
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.width * 0.1,
            alignment: Alignment.center,
            child: const Text(
              "Edit the movie",
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Delete this movie ?'),
                  content: const Text(
                    'If you delete this movie, it will also delete all the characters linked to this movie. Are you sure ?',
                  ),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Close')),
                    TextButton(
                      onPressed: () {
                        BlocProvider.of<MovieBloc>(context).add(
                          DeleteMovie(movie: movie),
                        );
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text('Delete the movie'),
                    ),
                  ],
                );
              },
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.width * 0.05,
            alignment: Alignment.center,
            child: const Text(
              "Delete the movie",
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
      ],
    );
  }
}
