import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../models/models.dart';

import '../../repository/auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    @required this.authRepository,
  }) : assert(authRepository != null, 'auth repository cannot be null');

  final AuthRepository authRepository;

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginInProgress();
      final Token token = await authRepository.generateToken(
        event.email,
        event.password,
      );
      if (token.error != null) {
        yield LoginFailure(
          error: token.error,
          errorCode: token.errorCode,
        );
        return;
      }
      await authRepository.persistToken(token);
      await authRepository.persistLogInState(loggedIn: true);
      yield LoginSuccess();
      return;
    }
  }
}
