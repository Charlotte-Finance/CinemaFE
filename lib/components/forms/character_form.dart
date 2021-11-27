import 'package:cinema_fe/blocs/forms/character/character_bloc.dart';
import 'package:cinema_fe/components/widgets/forms/forms.dart';
import 'package:cinema_fe/models/actor.dart';
import 'package:cinema_fe/models/character.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterForm extends StatefulWidget {
  final Character character;
  final List<Actor> actors;
  final List<Movie> movies;

  const CharacterForm({
    Key? key,
    required this.character,
    required this.actors,
    required this.movies,
  }) : super(key: key);

  @override
  _CharacterFormState createState() => _CharacterFormState();
}

class _CharacterFormState extends State<CharacterForm> {
  final _formKey = GlobalKey<FormState>();
  late Character character;

  @override
  void initState() {
    character = widget.character;
    super.initState();
  }
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
              initialValue: character.name,
              onChanged: (answer) => character.name = answer,
              onSaved: (answer) => character.name = answer,
            ),
            DropDownFormQuestion(
              question: "Actor",
              category: "actor",
              selectedItem: character.actor,
              items: widget.actors,
              itemAsString: (items) => "${items.firstname} ${items.name}",
              onChanged: (actor) => setState(() {
                character.actorId = actor.id;
              }),
              onSaved: (actor) => setState(() {
                character.actorId = actor.id;
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
              selectedItem: character.movie,
              items: widget.movies,
              itemAsString: (items) => "${items.title}",
              onChanged: (movie) => setState(() {
                character.movieId = movie.id;
              }),
              onSaved: (movie) => setState(() {
                character.movieId = movie.id;
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
                  BlocProvider.of<CharacterBloc>(context).add(
                    AddCharacter(character: character),
                  );
                  Navigator.pop(context);
                }
              },
              child: character.id == null ? const Text("Add") : const Text("Edit"),
            ),
          ],
        ),
      ),
    );
  }
}
