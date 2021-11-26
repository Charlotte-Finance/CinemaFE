part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class Login extends LoginEvent {
  final User user;

  const Login({required this.user});

  @override
  List<Object> get props => [user];
}
