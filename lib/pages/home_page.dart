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
        } else if (state is HomePageLoaded) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Headline',
                style: TextStyle(fontSize: 18),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: state.movies.length,
                  itemBuilder: (BuildContext context, int index) => const Card(
                    child: Center(child: Text('Dummy Card Text')),
                  ),
                ),
              ),
              const Text(
                'Demo Headline 2',
                style: TextStyle(fontSize: 18),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    return Card(
                      child: ListTile(
                          title: Text('Motivation $index'),
                          subtitle: const Text(
                              'this is a description of the motivation')),
                    );
                  },
                ),
              ),
            ],
          );
        } else if (state is HomePageError) {
          return ErrorMessage(
            error: state.error,
            bloc: BlocProvider.of<HomePageBloc>(context),
            event: state.event,
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
