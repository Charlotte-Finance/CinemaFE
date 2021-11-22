import 'package:cinema_fe/blocs/add_tab/add_tab_bloc.dart';
import 'package:cinema_fe/blocs/movies_tab/movies_tab_bloc.dart';
import 'package:cinema_fe/components/widgets/forms/forms.dart';
import 'package:cinema_fe/models/director.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class DirectorForm extends StatefulWidget {
  final Director director;
  final bool create;

  const DirectorForm({
    required this.director,
    required this.create,
    Key? key,
  }) : super(key: key);

  @override
  _DirectorFormState createState() => _DirectorFormState();
}

class _DirectorFormState extends State<DirectorForm> {
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
              initialValue: widget.director.firstname,
              onChanged: (answer) => widget.director.firstname = answer,
              onSaved: (answer) => widget.director.firstname = answer,
            ),
            TextFormQuestion(
              question: "Firstname",
              initialValue: widget.director.name,
              onChanged: (answer) => widget.director.firstname = answer,
              onSaved: (answer) => widget.director.firstname = answer,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  if (widget.create) {
                    Provider.of<AddTabBloc>(context, listen: false).add(
                      AddDirector(
                        director: widget.director,
                      ),
                    );
                  } else {
                    Provider.of<MoviesTabBloc>(context, listen: false).add(
                      EditDirector(
                        director: widget.director,
                      ),
                    );
                  }

                }
              },
              child: const Text("Add the director"),
            ),
          ],
        ),
      ),
    );
  }
}
