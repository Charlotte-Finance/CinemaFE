import 'package:cinema_fe/blocs/actor/actor_bloc.dart';
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

  @override
  void initState() {
    super.initState();
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
              initialValue: widget.actor.name,
              onChanged: (answer) => widget.actor.name = answer,
              onSaved: (answer) => widget.actor.name = answer,
            ),
            TextFormQuestion(
              question: "Firstname",
              initialValue: widget.actor.firstname,
              onChanged: (answer) => widget.actor.firstname = answer,
              onSaved: (answer) => widget.actor.firstname = answer,
            ),
            DateFormQuestion(
              question: "Birth date",
              initialValue: widget.actor.birth,
              onChanged: (date) => setState(() => widget.actor.birth =
                  DateTime.parse(formatDate.format(DateTime.parse(date!)))),
              onSaved: (date) => setState(() => widget.actor.birth =
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
                initialValue: widget.actor.death,
                onChanged: (date) => setState(() => widget.actor.death =
                    DateTime.parse(formatDate.format(DateTime.parse(date!)))),
                onSaved: (date) => setState(() => widget.actor.death =
                    DateTime.parse(formatDate.format(DateTime.parse(date!)))),
                controller: deathCtl,
              ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  BlocProvider.of<ActorBloc>(context).add(
                    AddActor(actor: widget.actor),
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
