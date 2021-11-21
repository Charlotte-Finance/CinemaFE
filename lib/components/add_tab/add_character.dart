import 'package:cinema_fe/blocs/add_tab/add_tab_bloc.dart';
import 'package:cinema_fe/components/widgets/forms/forms.dart';
import 'package:cinema_fe/models/actor.dart';
import 'package:cinema_fe/models/category.dart';
import 'package:cinema_fe/models/director.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';

class AddCharacterForm extends StatefulWidget {
  final List<Actor> actors;
  final List<Movie> movies;

  const AddCharacterForm({
    Key? key,
    required this.actors,
    required this.movies,
  }) : super(key: key);

  @override
  AddCharacterFormState createState() {
    return AddCharacterFormState();
  }
}

class AddCharacterFormState extends State<AddCharacterForm> {
  late String name;
  late int actorId;
  late int movieId;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormQuestion(
              question: "Name",
              onChanged: (answer) => name = answer,
              onSaved: (answer) => name = answer,
            ),
            DropDownFormQuestion(
              question: "Actor",
              category: "actor",
              items: widget.actors,
              itemAsString: (items) => "${items.firstname} ${items.name}",
              onChanged: (actor) => setState(() {
                actorId = actor.id;
              }),
              onSaved: (actor) => setState(() {
                actorId = actor.id;
              }),
              validator: (value) {
                if (value == null) {
                  return 'Please choose the actor';
                }
                return null;
              },
            ),
            DropDownFormQuestion(
              question: "Movie",
              category: "movie",
              items: widget.movies,
              itemAsString: (items) => "${items.title}",
              onChanged: (movie) => setState(() {
                movieId = movie.id;
              }),
              onSaved: (movie) => setState(() {
                movieId = movie.id;
              }),
              validator: (value) {
                if (value == null) {
                  return 'Please choose the movie';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Provider.of<AddTabBloc>(context, listen: false).add(
                    AddCharacter(
                      name: name,
                      actorId: actorId,
                      movieId: movieId,
                    ),
                  );
                }
              },
              child: const Text("Add the character"),
            ),
          ],
        ),
      ),
    );
  }
}
