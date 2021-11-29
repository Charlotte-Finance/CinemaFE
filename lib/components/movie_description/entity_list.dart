import 'package:cinema_fe/blocs/forms/character/character_bloc.dart';
import 'package:cinema_fe/blocs/forms/forms_bloc.dart';
import 'package:cinema_fe/models/character.dart';
import 'package:cinema_fe/models/director.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/utils/image.dart';
import 'package:cinema_fe/utils/routes/route_arguments.dart';
import 'package:cinema_fe/utils/routes/routing_constants.dart';
import 'package:cinema_fe/utils/styles/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EntityList extends StatelessWidget {
  final User user;
  final List<dynamic> entities;
  final bool isDeletable;
  final bool isActor;

  const EntityList({
    Key? key,
    required this.user,
    required this.entities,
    this.isDeletable = false,
    this.isActor = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        Container(
          padding: const EdgeInsets.only(left: 30.0),
          alignment: Alignment.centerLeft,
          child: Text(
            _getLabel(entities[0], isActor),
            style: subtitleStyle,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: 10000,
          height: 500,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: entities.length,
            itemBuilder: (ctx, index) {
              return Column(
                children: [
                  Image(
                    image: AssetImage(_getPath(entities[index], isActor)),
                    width: pictureWidth,
                    height: pictureHeight,
                    fit: BoxFit.contain,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 350,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.create_rounded),
                          onPressed: () {
                            BlocProvider.of<FormsBloc>(context)
                                .add(_getEvent(entities[0], isActor)!);
                            Navigator.pushNamed(
                              context,
                              formRoute,
                              arguments: UserArgument(user: user),
                            );
                          },
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              _getText(entities[index], isActor),
                              style: const TextStyle(fontSize: 20),
                            ),
                            if (isActor)
                              Text(
                                entities[index].name!,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.orange,
                                ),
                              ),
                          ],
                        ),
                        _getDeleteIcon(context, entities[index], isDeletable),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

String _getLabel(dynamic entity, bool isActor) {
  return isActor
      ? "Actors"
      : entity is Character
          ? "Characters"
          : entity is Director
              ? "Directors"
              : "";
}

String _getPath(dynamic entity, bool isActor) {
  return 'lib/assets/' +
      (isActor
          ? 'actors/${entity.actor!.firstname} ${entity.actor!.name}.jpg'
          : entity is Character
              ? 'characters/${entity.name}.jpg'
              : entity is Director
                  ? 'directors/${entity.firstname} ${entity.name}.jpg'
                  : '');
}

FormsEvent? _getEvent(dynamic entity, bool isActor) {
  return isActor
      ? GetActorForm(actor: entity.actor!)
      : entity is Character
          ? GetCharacterForm(character: entity)
          : entity is Director
              ? GetDirectorForm(director: entity)
              : null;
}

String _getText(dynamic entity, bool isActor) {
  return isActor
      ? entity.actor!.firstname! + " " + entity.actor!.name!
      : entity is Character
          ? entity.name!
          : entity is Director
              ? entity.firstname! + " " + entity.name!
              : "";
}

IconButton _getDeleteIcon(
    BuildContext context, dynamic entity, bool isDeletable) {
  return isDeletable && entity is Character
      ? IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Delete this character ?'),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Close')),
                    TextButton(
                      onPressed: () {
                        BlocProvider.of<CharacterBloc>(context).add(
                          DeleteCharacter(character: entity),
                        );
                        Navigator.pop(context);
                      },
                      child: const Text('Delete'),
                    )
                  ],
                );
              },
            );
          },
        )
      : IconButton(
          icon: Icon(
            Icons.create_rounded,
            color: Colors.red.withOpacity(0),
          ),
          onPressed: () {},
        );
}
