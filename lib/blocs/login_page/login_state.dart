part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginLoaded extends LoginState {
  final bool failed;

  const LoginLoaded({required this.failed});
  @override
  List<Object> get props => [failed];
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class Logged extends LoginState {
  final User user;

  const Logged({required this.user});

  @override
  List<Object> get props => [user];
}
