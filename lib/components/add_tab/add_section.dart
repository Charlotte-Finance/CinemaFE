import 'package:cinema_fe/blocs/forms/forms_bloc.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/utils/routes/route_arguments.dart';
import 'package:cinema_fe/utils/routes/routing_constants.dart';
import 'package:cinema_fe/utils/styles/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddSection extends StatelessWidget {
  final User user;
  final String path;
  final FormsEvent event;
  final String text;
  final Alignment beginAlignment;
  final Alignment endAlignment;
  final double height;

  const AddSection({
    Key? key,
    required this.user,
    required this.path,
    required this.event,
    required this.text,
    required this.beginAlignment,
    required this.endAlignment,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<FormsBloc>().add(event);
        Navigator.pushNamed(context, formRoute,
            arguments: UserArgument(user: user));
      },
      child: Stack(
        children: <Widget>[
          Image(
            height: height,
            width: MediaQuery.of(context).size.width,
            image: AssetImage('lib/assets/backgrounds/$path'),
            fit: BoxFit.cover,
          ),
          Align(
            child: Container(
              padding: const EdgeInsets.all(20),
              height: height,
              alignment: beginAlignment,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                  begin: beginAlignment,
                  end: endAlignment,
                  colors: [
                    Colors.black.withOpacity(0.9),
                    Colors.black.withOpacity(0.0),
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Text(
                    text,
                    style: addSectionStyle,
                  ),
                  Text(
                    text,
                    style: addSectionBorderStyle,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
