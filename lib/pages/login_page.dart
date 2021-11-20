import 'package:cinema_fe/blocs/login_page/login_bloc.dart';
import 'package:cinema_fe/utils/route_arguments.dart';
import 'package:cinema_fe/utils/text_styles.dart';
import 'package:cinema_fe/utils/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  final String route;

  const LoginPage({
    Key? key,
    required this.route,
  }) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CineMovies'),
      ),
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginLoaded) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  if (state.failed)
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        errorLoginStr,
                        style: errorStyle,
                      ),
                    ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User Name',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        context.read<LoginBloc>().add(
                              Login(
                                username: nameController.text,
                                password: passwordController.text,
                              ),
                            );
                      },
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: <Widget>[
                      const Text('Does not have account?'),
                      const SizedBox(width: 25),
                      ElevatedButton(
                        child: const Text(
                          'Sign in',
                        ),
                        onPressed: () {
                          //signup screen
                        },
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  )
                ],
              ),
            );
          } else if (state is Logged) {
            WidgetsBinding.instance!.addPostFrameCallback((_){
              Navigator.pushNamedAndRemoveUntil(
                context,
                widget.route,
                ModalRoute.withName(widget.route),
                arguments: UserArgument(user: state.user),
              );
              // Add Your Code here.

            });

          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
