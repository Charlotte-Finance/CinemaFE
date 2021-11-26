import 'package:cinema_fe/blocs/forms/director/director_bloc.dart';
import 'package:cinema_fe/blocs/forms/forms_bloc.dart';
import 'package:cinema_fe/models/director.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/utils/route_arguments.dart';
import 'package:cinema_fe/utils/routing_constants.dart';
import 'package:cinema_fe/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DirectorList extends StatelessWidget {
  final User user;
  final List<Director> directors;

  const DirectorList({
    Key? key,
    required this.user,
    required this.directors,
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
            "Directors",
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
            itemCount: directors.length,
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
                            'lib/assets/directors/${directors[index].firstname} ${directors[index].name}.jpg',
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
                                GetDirectorForm(director: directors[index]),
                              );
                              Navigator.pushNamed(
                                context,
                                FormRoute,
                                arguments: UserArgument(user: user),
                              );
                            },
                          ),
                          Text(
                            directors[index].firstname! +
                                " " +
                                directors[index].name!,
                            style: const TextStyle(fontSize: 20),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              BlocProvider.of<DirectorBloc>(context)
                                  .add(
                                DeleteDirector(director: directors[index]),
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
