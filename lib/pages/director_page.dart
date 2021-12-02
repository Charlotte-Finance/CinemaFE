import 'package:cinema_fe/blocs/director_description/director_description_bloc.dart';
import 'package:cinema_fe/components/director_description/director_description.dart';
import 'package:cinema_fe/components/widgets/error_message.dart';
import 'package:cinema_fe/models/director.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/utils/styles/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DirectorPage extends StatefulWidget {
  final User user;
  final Director director;

  const DirectorPage({
    Key? key,
    required this.user,
    required this.director,
  }) : super(key: key);

  @override
  State<DirectorPage> createState() => _DirectorPageState();
}

class _DirectorPageState extends State<DirectorPage> {
  late Director director;

  @override
  void initState() {
    director = widget.director;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${director.firstname} ${director.name}"),
        leading: IconButton(
          icon: backArrow,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (BuildContext context) => DirectorDescriptionBloc(),
          child: BlocBuilder<DirectorDescriptionBloc, DirectorDescriptionState>(
            builder: (context, state) {
              if (state is DirectorDescriptionEmpty) {
                BlocProvider.of<DirectorDescriptionBloc>(context).add(
                  FetchDirectorDescription(
                    director: director,
                  ),
                );
              } else if (state is DirectorDescriptionLoaded) {
                if (state.movies.isNotEmpty) {
                  return DirectorDescription(
                    user: widget.user,
                    director: director,
                    movies: state.movies,
                  );
                }
              } else if (state is DirectorDescriptionError) {
                return ErrorMessage(
                  error: state.error,
                  bloc: BlocProvider.of<DirectorDescriptionBloc>(context),
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
