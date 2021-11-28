import 'package:cinema_fe/blocs/forms/character/character_bloc.dart';
import 'package:cinema_fe/blocs/forms/forms_bloc.dart';
import 'package:cinema_fe/models/character.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/utils/routes/route_arguments.dart';
import 'package:cinema_fe/utils/routes/routing_constants.dart';
import 'package:cinema_fe/utils/styles/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterList extends StatelessWidget {
  final User user;
  final List<Character> characters;

  const CharacterList({
    Key? key,
    required this.user,
    required this.characters,
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
            "Characters",
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
            shrinkWrap: false,
            scrollDirection: Axis.horizontal,
            itemCount: characters.length,
            itemBuilder: (ctx, index) {
              return SizedBox(
                height: 500,
                child: Column(
                  children: [
                    Container(
                      height: 400,
                      width: 350,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'lib/assets/characters/${characters[index].name}.jpg',
                          ),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
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
                              BlocProvider.of<FormsBloc>(context).add(
                                GetCharacterForm(character: characters[index]),
                              );
                              Navigator.pushNamed(
                                context,
                                FormRoute,
                                arguments: UserArgument(user: user),
                              );
                            },
                          ),
                          Text(
                            characters[index].name!,
                            style: const TextStyle(fontSize: 20),
                          ),
                          IconButton(
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
                                            DeleteCharacter(character: characters[index]),
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
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
