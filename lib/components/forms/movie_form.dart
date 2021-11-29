import 'package:cinema_fe/blocs/movie/movie_bloc.dart';
import 'package:cinema_fe/blocs/picture/picture_bloc.dart';
import 'package:cinema_fe/components/forms/picture_button.dart';
import 'package:cinema_fe/blocs/forms/movie/movie_bloc.dart';
import 'package:cinema_fe/components/widgets/forms/forms.dart';
import 'package:cinema_fe/models/category.dart';
import 'package:cinema_fe/models/director.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MovieForm extends StatefulWidget {
  final Movie movie;
  final List<Director> directors;
  final List<Category> categories;

  const MovieForm({
    Key? key,
    required this.movie,
    required this.directors,
    required this.categories,
  }) : super(key: key);

  @override
  _MovieFormState createState() => _MovieFormState();
}

class _MovieFormState extends State<MovieForm> {
  late TextEditingController releaseCtl;
  final _formKey = GlobalKey<FormState>();
  final formatDate = DateFormat('yyyy-MM-dd');
  late Movie movie;

  @override
  void initState() {
    releaseCtl = TextEditingController(
      text: widget.movie.release.toString() == "null"
          ? null
          : widget.movie.release.toString(),
    );
    movie = widget.movie;
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
              question: "Title",
              initialValue: movie.title,
              onChanged: (answer) => movie.title = answer,
              onSaved: (answer) => movie.title = answer,
            ),
            NumberFormQuestion(
              question: "Duration",
              initialValue: movie.duration.toString(),
              onChanged: (answer) => movie.duration = int.parse(answer),
              onSaved: (answer) => movie.duration = int.parse(answer),
            ),
            DateFormQuestion(
              question: "Release",
              initialValue: movie.release,
              onChanged: (date) => setState(() =>
                  movie.release = formatDate.format(DateTime.parse(date!))),
              onSaved: (date) => setState(() =>
                  movie.release = formatDate.format(DateTime.parse(date!))),
              controller: releaseCtl,
            ),
            NumberFormQuestion(
              question: "Budget",
              initialValue: movie.budget.toString(),
              onChanged: (answer) => movie.budget = int.parse(answer),
              onSaved: (answer) => movie.budget = int.parse(answer),
            ),
            NumberFormQuestion(
              question: "Revenue",
              initialValue: movie.revenue.toString(),
              onChanged: (answer) => movie.revenue = int.parse(answer),
              onSaved: (answer) => movie.revenue = int.parse(answer),
            ),
            DropDownFormQuestion(
              question: "Director",
              category: "director",
              selectedItem: movie.director,
              items: widget.directors,
              itemAsString: (items) => "${items.firstname} ${items.name}",
              onSaved: (director) => setState(() {
                movie.directorId = director.id;
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
              selectedItem: movie.category,
              items: widget.categories,
              itemAsString: (items) => "${items.label}",
              onSaved: (category) => setState(() {
                movie.categoryCode = category.code;
              }),
              validator: (value) {
                if (value == null) {
                  return 'Please choose the category';
                }
                return null;
              },
            ),
            BlocProvider(
                create: (BuildContext context) => PictureBloc(),
                child: const PictureButton()),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  BlocProvider.of<MovieBloc>(context).add(
                    AddMovie(movie: movie),
                  );
                  Navigator.pop(context);
                }
              },
              child: movie.id == null ? const Text("Add") : const Text("Edit"),
            ),
          ],
        ),
      ),
    );
  }
}
