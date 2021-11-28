
import 'package:cinema_fe/components/add_tab/add_tab.dart';
import 'package:cinema_fe/components/liked_tab/liked_tab.dart';
import 'package:cinema_fe/components/movies_tab/movies_tab.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/utils/styles/texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppPage extends StatefulWidget {
  final User user;

  const AppPage({Key? key, required this.user}) : super(key: key);

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[];

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
        title: _selectedIndex == 0
            ? Text(moviesTabStr)
            : _selectedIndex == 1
                ? Text(likeTabStr)
                : Text(formTabStr),
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
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.movie),
            label: moviesTabStr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite),
            label: likeTabStr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.add_circle),
            label: formTabStr,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
