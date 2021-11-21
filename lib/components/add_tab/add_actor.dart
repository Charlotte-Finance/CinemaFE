import 'package:cinema_fe/blocs/add_tab/add_tab_bloc.dart';
import 'package:cinema_fe/components/widgets/forms/forms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';

class AddActorForm extends StatefulWidget {
  const AddActorForm({
    Key? key,
  }) : super(key: key);

  @override
  AddActorFormState createState() {
    return AddActorFormState();
  }
}

class AddActorFormState extends State<AddActorForm> {
  late String name;
  late String firstname;
  late TextEditingController birthCtl;
  DateTime? birth;
  late TextEditingController deathCtl;
  DateTime? death;
  final _formKey = GlobalKey<FormState>();
  final formatDate = DateFormat('yyyy-MM-dd');
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    birthCtl = TextEditingController(
      text: birth.toString() == "null" ? null : birth.toString(),
    );
    deathCtl = TextEditingController(
      text: death.toString() == "null" ? null : death.toString(),
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
              question: "Name",
              onChanged: (answer) => name = answer,
              onSaved: (answer) => name = answer,
            ),
            TextFormQuestion(
              question: "Firstname",
              onChanged: (answer) => firstname = answer,
              onSaved: (answer) => firstname = answer,
            ),
            DateFormQuestion(
              question: "Birth date",
              onChanged: (date) => setState(() => birth =
                  DateTime.parse(formatDate.format(DateTime.parse(date!)))),
              onSaved: (date) => setState(() => birth =
                  DateTime.parse(formatDate.format(DateTime.parse(date!)))),
              controller: birthCtl,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Text("Is dead"),
                  Checkbox(
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
            if (isChecked)
              DateFormQuestion(
                question: "Death date",
                onChanged: (date) => setState(() => death =
                    DateTime.parse(formatDate.format(DateTime.parse(date!)))),
                onSaved: (date) => setState(() => death =
                    DateTime.parse(formatDate.format(DateTime.parse(date!)))),
                controller: deathCtl,
              ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Provider.of<AddTabBloc>(context, listen: false).add(
                    AddActor(
                      name: name,
                      firstname: firstname,
                      birth: birth!,
                      death: death,
                    ),
                  );
                }
              },
              child: const Text("Add the actor"),
            ),
          ],
        ),
      ),
    );
  }
}
