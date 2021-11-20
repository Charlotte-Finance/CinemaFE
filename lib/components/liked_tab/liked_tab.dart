import 'package:cinema_fe/blocs/home_page/home_page_bloc.dart';
import 'package:cinema_fe/blocs/my_favourites/my_favourites_bloc.dart';
import 'package:cinema_fe/components/error_message.dart';
import 'package:cinema_fe/components/movie_card.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyFavouritesPage extends StatelessWidget {
  final User? user;

  const MyFavouritesPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyFavouritesBloc, MyFavouritesState>(
      builder: (context, state) {
        if (state is MyFavouritesEmpty) {
          context.watch<MyFavouritesBloc>().add(const GetFavouriteMovies());
        } else if (state is MyFavouritesLoaded) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.movies.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  MovieCard(movie: state.movies[index]),
                ],
              );
            },
          );
        } else if (state is MyFavouritesError) {
          return ErrorMessage(
            error: state.error,
            bloc: BlocProvider.of<MyFavouritesBloc>(context),
            event: state.event,
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
