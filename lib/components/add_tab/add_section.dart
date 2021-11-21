import 'dart:ui';

import 'package:cinema_fe/blocs/add_tab/add_tab_bloc.dart';
import 'package:cinema_fe/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddSection extends StatelessWidget {
  final String path;
  final AddTabEvent event;
  final String text;
  final Alignment beginAlignment;
  final Alignment endAlignment;

  const AddSection({
    Key? key,
    required this.path,
    required this.event,
    required this.text,
    required this.beginAlignment,
    required this.endAlignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTabBloc, AddTabState>(
      builder: (context, state) {
        return Expanded(
          child: GestureDetector(
            onTap: () {
              context.read<AddTabBloc>().add(event);
            },
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/assets/backgrounds/$path'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                      height: 350.0,
                      alignment: beginAlignment,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          gradient: LinearGradient(
                              begin: beginAlignment,
                              end: endAlignment,
                              colors: [
                                Colors.white.withOpacity(0.9),
                                Colors.white.withOpacity(0.0),
                              ],
                              stops: const [
                                0.0,
                                1.0
                              ])),
                      child: Stack(
                        children: <Widget>[
                          // Stroked text as border.
                          Text(
                            text,
                            style: addSectionStyle,
                          ),
                          // Solid text as fill.
                          Text(
                            text,
                            style: addSectionBorderStyle,
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
