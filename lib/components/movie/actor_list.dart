
import 'package:cinema_fe/blocs/actor/actor_bloc.dart';
import 'package:cinema_fe/blocs/forms/forms_bloc.dart';
import 'package:cinema_fe/models/character.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/utils/route_arguments.dart';
import 'package:cinema_fe/utils/routing_constants.dart';
import 'package:cinema_fe/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActorList extends StatelessWidget {
  final User user;
  final List<Character> characters;

  const ActorList({
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
            "Actors",
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
                            'lib/assets/actors/${characters[index].actor!.firstname} ${characters[index].actor!.name}.jpg',
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
                                GetActorForm(actor: characters[index].actor!),
                              );
                              Navigator.pushNamed(
                                context,
                                FormRoute,
                                arguments: UserArgument(user: user),
                              );
                            },
                          ),
                          Column(
                            children: [
                              const SizedBox(height: 8,),
                              Text(
                                characters[index].actor!.firstname! +
                                    " " +
                                    characters[index].actor!.name!,
                                style: const TextStyle(fontSize: 20),
                              ),
                              Text(
                                characters[index].name!,
                                style: const TextStyle(fontSize: 15, color: Colors.orange),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              BlocProvider.of<ActorBloc>(context).add(
                                DeleteActor(actor: characters[index].actor!),
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
