import 'package:cinema_fe/blocs/add_tab/add_tab_bloc.dart';
import 'package:cinema_fe/components/widgets/forms/forms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class AddDirectorForm extends StatefulWidget {
  const AddDirectorForm({
    Key? key,
  }) : super(key: key);

  @override
  AddDirectorFormState createState() {
    return AddDirectorFormState();
  }
}

class AddDirectorFormState extends State<AddDirectorForm> {
  late String name;
  late String firstname;
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
              onChanged: (answer) => firstname = answer,
              onSaved: (answer) => firstname = answer,
            ),
            TextFormQuestion(
              question: "Firstname",
              onChanged: (answer) => firstname = answer,
              onSaved: (answer) => firstname = answer,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Provider.of<AddTabBloc>(context, listen: false).add(
                    AddDirector(
                      name: name,
                      firstname: firstname,
                    ),
                  );
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
