import 'package:bloc/bloc.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository = UserRepository();

  LoginBloc() : super(const LoginLoaded(failed: false));

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is Login) {
      yield* _mapLogin(event);
    }
  }

  Stream<LoginState> _mapLogin(Login event) async* {
    try {
      User user = await userRepository.login(event.user);
      yield Logged(user: user);
    } catch (_) {
      yield const LoginLoaded(failed: true);
    }
  }
}
