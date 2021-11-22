import 'dart:collection';

import 'package:cinema_fe/blocs/add_tab/add_tab_bloc.dart';
import 'package:cinema_fe/blocs/movies_tab/movies_tab_bloc.dart';
import 'package:cinema_fe/components/widgets/forms/forms.dart';
import 'package:cinema_fe/models/category.dart';
import 'package:cinema_fe/models/director.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';

class MovieForm extends StatefulWidget {
  final HashMap? movies;
  final Movie movie;
  final List<Director> directors;
  final List<Category> categories;
  final bool create;

  const MovieForm({
    Key? key,
    this.movies,
    required this.movie,
    required this.directors,
    required this.categories,
    required this.create,
  }) : super(key: key);

  @override
  _MovieFormState createState() => _MovieFormState();
}

class _MovieFormState extends State<MovieForm> {
  late TextEditingController releaseCtl;
  final _formKey = GlobalKey<FormState>();
  final formatDate = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    releaseCtl = TextEditingController(
      text: widget.movie.release.toString() == "null"
          ? null
          : widget.movie.release.toString(),
    );
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
              question: "Title",
              initialValue: widget.movie.title,
              onChanged: (answer) => widget.movie.title = answer,
              onSaved: (answer) => widget.movie.title = answer,
            ),
            NumberFormQuestion(
              question: "Duration",
              initialValue: widget.movie.duration.toString(),
              onChanged: (answer) => widget.movie.duration = int.parse(answer),
              onSaved: (answer) => widget.movie.duration = int.parse(answer),
            ),
            DateFormQuestion(
              question: "Release",
              initialValue: widget.movie.release,
              onChanged: (date) => setState(() => widget.movie.release =
                  DateTime.parse(formatDate.format(DateTime.parse(date!)))),
              onSaved: (date) => setState(() => widget.movie.release =
                  DateTime.parse(formatDate.format(DateTime.parse(date!)))),
              controller: releaseCtl,
            ),
            NumberFormQuestion(
              question: "Budget",
              initialValue: widget.movie.budget.toString(),
              onChanged: (answer) => widget.movie.budget = int.parse(answer),
              onSaved: (answer) => widget.movie.budget = int.parse(answer),
            ),
            NumberFormQuestion(
              question: "Revenue",
              initialValue: widget.movie.revenue.toString(),
              onChanged: (answer) => widget.movie.revenue = int.parse(answer),
              onSaved: (answer) => widget.movie.revenue = int.parse(answer),
            ),
            DropDownFormQuestion(
              question: "Director",
              category: "director",
              selectedItem: widget.movie.director,
              items: widget.directors,
              itemAsString: (items) => "${items.firstname} ${items.name}",
              onSaved: (director) => setState(() {
                widget.movie.directorId = director.id;
              }),
              validator: (value) {
                if (value == null) {
                  return 'Please choose the director';
                }
                return null;
              },
            ),
            DropDownFormQuestion(
              question: "Category",
              category: "category",
              selectedItem: widget.movie.category,
              items: widget.categories,
              itemAsString: (items) => "${items.label}",
              onSaved: (category) => setState(() {
                widget.movie.categoryCode = category.code;
              }),
              validator: (value) {
                if (value == null) {
                  return 'Please choose the category';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  if (widget.create) {
                    Provider.of<AddTabBloc>(context, listen: false).add(
                      AddMovie(movie: widget.movie),
                    );
                  } else {
                    Provider.of<MoviesTabBloc>(context, listen: false).add(
                      EditMovie(movie: widget.movie),
                    );
                  }
                }
              },
              child: const Text("Add the movie"),
            ),
          ],
        ),
      ),
    );
  }
}
