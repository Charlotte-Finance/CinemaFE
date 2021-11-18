import 'package:cinema_fe/blocs/home_page/home_page_bloc.dart';
import 'package:cinema_fe/components/error_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        if (state is HomePageEmpty) {
          context.watch<HomePageBloc>().add(GetMovies());
        }
        else if (state is HomePageLoaded) {
          return const Text("AAAAAAAAAAAA");
        }
        else if (state is HomePageError) {
          return ErrorMessage(
            error: state.error,
            bloc: BlocProvider.of<HomePageBloc>(context),
            event: state.event,
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
