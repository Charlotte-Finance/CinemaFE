import 'package:cinema_fe/blocs/actor_description/actor_description_bloc.dart';
import 'package:cinema_fe/components/actor_description/actor_description.dart';
import 'package:cinema_fe/components/widgets/error_message.dart';
import 'package:cinema_fe/models/actor.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/utils/styles/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActorPage extends StatefulWidget {
  final User user;
  final Actor actor;

  const ActorPage({
    Key? key,
    required this.user,
    required this.actor,
  }) : super(key: key);

  @override
  State<ActorPage> createState() => _ActorPageState();
}

class _ActorPageState extends State<ActorPage> {
  late Actor actor;

  @override
  void initState() {
    actor = widget.actor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${actor.firstname} ${actor.name}"),
        leading: IconButton(
          icon: backArrow,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (BuildContext context) => ActorDescriptionBloc(),
          child: BlocBuilder<ActorDescriptionBloc, ActorDescriptionState>(
            builder: (context, state) {
              if (state is ActorDescriptionEmpty) {
                BlocProvider.of<ActorDescriptionBloc>(context).add(
                  FetchActorDescription(
                    actor: actor,
                  ),
                );
              } else if (state is ActorDescriptionLoaded) {
                if (state.characters.isNotEmpty) {
                  return ActorDescription(
                    user: widget.user,
                    actor: actor,
                    characters: state.characters,
                  );
                }
              } else if (state is ActorDescriptionError) {
                return ErrorMessage(
                  error: state.error,
                  bloc: BlocProvider.of<ActorDescriptionBloc>(context),
                  event: state.event,
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
