import 'package:cinema_fe/blocs/forms/director/director_bloc.dart';
import 'package:cinema_fe/components/widgets/forms/forms.dart';
import 'package:cinema_fe/models/director.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DirectorForm extends StatefulWidget {
  final Director director;

  const DirectorForm({
    required this.director,
    Key? key,
  }) : super(key: key);

  @override
  _DirectorFormState createState() => _DirectorFormState();
}

class _DirectorFormState extends State<DirectorForm> {
  final _formKey = GlobalKey<FormState>();
  late Director director;

  @override
  void initState() {
    director = widget.director;
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
              question: "Firstname",
              initialValue: director.firstname,
              onChanged: (answer) => director.firstname = answer,
              onSaved: (answer) => director.firstname = answer,

            ),
            TextFormQuestion(
              question: "Name",
              initialValue: director.name,
              onChanged: (answer) => director.name = answer,
              onSaved: (answer) => director.name = answer,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  BlocProvider.of<DirectorBloc>(context).add(
                    AddDirector(
                      director: director,
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: director.id == null ? const Text("Add") : const Text("Edit"),
            ),
          ],
        ),
      ),
    );
  }
}
