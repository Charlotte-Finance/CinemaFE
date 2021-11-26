import 'package:cinema_fe/blocs/login/login_bloc.dart';
import 'package:cinema_fe/components/widgets/forms/forms.dart';
import 'package:cinema_fe/models/user.dart';
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
  User user = User();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CineMovies'),
        leading: null,
      ),
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginLoaded) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
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
                  TextFormQuestion(
                    question: "Username",
                    onChanged: (answer) => user.username = answer,
                    onSaved: (answer) => user.username = answer,
                  ),
                  TextFormQuestion(
                    question: "Password",
                    obscureText: true,
                    onChanged: (answer) => user.password = answer,
                    onSaved: (answer) => user.password = answer,
                  ),
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
                              Login(user: user),
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
            WidgetsBinding.instance!.addPostFrameCallback(
              (_) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  widget.route,
                  ModalRoute.withName(widget.route),
                  arguments: UserArgument(user: state.user),
                );
              },
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
