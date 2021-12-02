import 'package:cinema_fe/components/movie_description/entity_list.dart';
import 'package:cinema_fe/models/actor.dart';
import 'package:cinema_fe/models/character.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/utils/image.dart';
import 'package:cinema_fe/utils/styles/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActorDescription extends StatelessWidget {
  final User user;
  final Actor actor;
  final List<Character> characters;

  const ActorDescription({
    Key? key,
    required this.user,
    required this.actor,
    required this.characters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text("${actor.firstname} ${actor.name}", style: movieTitleStyle),
              const SizedBox(
                height: 10,
              ),
              Image(
                image: AssetImage(
                    'lib/assets/actors/${actor.firstname} ${actor.name}.jpg'),
                width: pictureWidth,
                height: pictureHeight,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
        EntityList(
          user: user,
          entities: characters,
          isEditable: false,
          showMovieTitle: true,
        ),
      ],
    );
  }
}
