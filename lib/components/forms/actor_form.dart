import 'package:cinema_fe/blocs/forms/actor/actor_bloc.dart';
import 'package:cinema_fe/components/widgets/forms/forms.dart';
import 'package:cinema_fe/models/actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ActorForm extends StatefulWidget {
  final Actor actor;

  const ActorForm({
    required this.actor,
    Key? key,
  }) : super(key: key);

  @override
  _ActorFormState createState() => _ActorFormState();
}

class _ActorFormState extends State<ActorForm> {
  late TextEditingController birthCtl;
  late TextEditingController deathCtl;
  final _formKey = GlobalKey<FormState>();
  final formatDate = DateFormat('yyyy-MM-dd');
  late bool isChecked;
  late Actor actor;

  @override
  void initState() {
    isChecked = widget.actor.death != null;
    birthCtl = TextEditingController(
      text: widget.actor.birth.toString() == "null"
          ? null
          : widget.actor.birth.toString(),
    );
    deathCtl = TextEditingController(
      text: widget.actor.death.toString() == "null"
          ? null
          : widget.actor.death.toString(),
    );
    actor = widget.actor;
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
              initialValue: actor.name,
              onChanged: (answer) => actor.name = answer,
              onSaved: (answer) => actor.name = answer,
            ),
            TextFormQuestion(
              question: "Firstname",
              initialValue: actor.firstname,
              onChanged: (answer) => actor.firstname = answer,
              onSaved: (answer) => actor.firstname = answer,
            ),
            DateFormQuestion(
              question: "Birth date",
              initialValue: actor.birth,
              onChanged: (date) => setState(
                  () => actor.birth = formatDate.format(DateTime.parse(date!))),
              onSaved: (date) => setState(
                () => actor.birth = formatDate.format(DateTime.parse(date!)),
              ),
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
                initialValue: actor.death,
                onChanged: (date) => () =>
                    actor.death = formatDate.format(DateTime.parse(date!)),
                onSaved: (date) => () =>
                    actor.death = formatDate.format(DateTime.parse(date!)),
                controller: deathCtl,
              ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  BlocProvider.of<ActorBloc>(context).add(
                    AddActor(actor: actor),
                  );
                  Navigator.pop(context);
                }
              },
              child: actor.id == null ? const Text("Add") : const Text("Edit"),
            ),
          ],
        ),
      ),
    );
  }
}
