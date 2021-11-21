import 'package:cinema_fe/blocs/add_tab/add_tab_bloc.dart';
import 'package:cinema_fe/components/widgets/forms/forms.dart';
import 'package:cinema_fe/models/category.dart';
import 'package:cinema_fe/models/director.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';

class AddMovieForm extends StatefulWidget {
  final List<Director> directors;
  final List<Category> categories;

  const AddMovieForm(
      {Key? key, required this.directors, required this.categories})
      : super(key: key);

  @override
  AddMovieFormState createState() {
    return AddMovieFormState();
  }
}

class AddMovieFormState extends State<AddMovieForm> {
  late String title;
  late int duration;
  late TextEditingController releaseCtl;
  DateTime? release;
  late int budget;
  late int revenue;
  late int directorId;
  late String categoryCode;
  final _formKey = GlobalKey<FormState>();
  final formatDate = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    releaseCtl = TextEditingController(
      text: release.toString() == "null" ? null : release.toString(),
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
              onChanged: (answer) => title = answer,
              onSaved: (answer) => title = answer,
            ),
            NumberFormQuestion(
              question: "Duration",
              onChanged: (answer) => duration = int.parse(answer),
              onSaved: (answer) => duration = int.parse(answer),
            ),
            DateFormQuestion(
              question: "Release",
              onChanged: (date) => setState(() => release =
                  DateTime.parse(formatDate.format(DateTime.parse(date!)))),
              onSaved: (date) => setState(() => release =
                  DateTime.parse(formatDate.format(DateTime.parse(date!)))),
              controller: releaseCtl,
            ),
            NumberFormQuestion(
              question: "Budget",
              onChanged: (answer) => budget = int.parse(answer),
              onSaved: (answer) => budget = int.parse(answer),
            ),
            NumberFormQuestion(
              question: "Revenue",
              onChanged: (answer) => revenue = int.parse(answer),
              onSaved: (answer) => revenue = int.parse(answer),
            ),
            DropDownFormQuestion(
              question: "Director",
              category: "director",
              items: widget.directors,
              itemAsString: (items) => "${items.firstname} ${items.name}",
              onSaved: (director) => setState(() {
                directorId = director.id;
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
              items: widget.categories,
              itemAsString: (items) => "${items.label}",
              onSaved: (category) => setState(() {
                categoryCode = category.code;
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
                  Provider.of<AddTabBloc>(context, listen: false).add(
                    AddMovie(
                      title: title,
                      duration: duration,
                      release: release!,
                      budget: budget,
                      revenue: revenue,
                      directorId: directorId,
                      categoryCode: categoryCode,
                    ),
                  );
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
