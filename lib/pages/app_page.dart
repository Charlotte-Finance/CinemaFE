import 'dart:collection';

import 'package:cinema_fe/blocs/add_tab/add_tab_bloc.dart';
import 'package:cinema_fe/blocs/movies_tab/movies_tab_bloc.dart';
import 'package:cinema_fe/components/add_tab/add_tab.dart';
import 'package:cinema_fe/components/liked_tab/liked_tab.dart';
import 'package:cinema_fe/components/movies_tab/movies_tab.dart';
import 'package:cinema_fe/models/actor.dart';
import 'package:cinema_fe/models/category.dart';
import 'package:cinema_fe/models/character.dart';
import 'package:cinema_fe/models/director.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';

class AppPage extends StatefulWidget {
  final User user;

  const AppPage({Key? key, required this.user}) : super(key: key);

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[];
  bool arrow = false;
  bool arrow2 = false;
  late HashMap movies;
  late Movie movie;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _widgetOptions = [
      MoviesTab(
        user: widget.user,
      ),
      LikedTab(
        user: widget.user,
      ),
      AddTab(
        user: widget.user,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CineMovies"),
        leading: _selectedIndex == 0
            ? BlocConsumer<MoviesTabBloc, MoviesTabState>(
                listener: (context, state) {
                  if (state is DescriptionLoaded) {
                    movies = state.movies;
                    movie = state.movie;
                    arrow = true;
                    arrow2 = false;
                  } else if (state is EditForm) {
                    movies = state.movies;
                    arrow = false;
                    arrow2 = true;
                  } else {
                    arrow = false;
                    arrow2 = false;
                  }
                },
                builder: (context, state) {
                  if (arrow) {
                    return IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Provider.of<MoviesTabBloc>(context, listen: false)
                            .add(GoBackMovies(movies: movies));
                      },
                      tooltip: MaterialLocalizations.of(context)
                          .openAppDrawerTooltip,
                    );
                  } else if (arrow2) {
                    return IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Provider.of<MoviesTabBloc>(context, listen: false).add(
                            GoBackMovie(
                                movies: movies,
                                movie: movie,
                                ));
                      },
                      tooltip: MaterialLocalizations.of(context)
                          .openAppDrawerTooltip,
                    );
                  }
                  return Container();
                },
              )
            : _selectedIndex == 2
                ? BlocConsumer<AddTabBloc, AddTabState>(
                    listener: (context, state) {
                      if (state is AddTabLoaded) {
                        arrow = false;
                        arrow2 = false;
                      } else {
                        arrow = true;
                        arrow2 = false;
                      }
                    },
                    builder: (context, state) {
                      if (arrow) {
                        return IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Provider.of<AddTabBloc>(context, listen: false)
                                .add(GoBack());
                          },
                          tooltip: MaterialLocalizations.of(context)
                              .openAppDrawerTooltip,
                        );
                      }
                      return Container();
                    },
                  )
                : null,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.person,
                size: 26.0,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Movies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Add Data',
          ),
        ],
        currentIndex: _selectedIndex,
        //selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
