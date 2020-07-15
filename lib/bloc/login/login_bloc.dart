import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../constants/constant.dart';
import '../../models/models.dart';

import '../../repository/user.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    @required this.userRepository,
  }) : assert(userRepository != null, 'partnerRepository cannot be null');

  final UserRepository userRepository;

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginInProgress();
      final Token token = await userRepository.generateToken(
        event.email,
        event.password,
      );
      if (token.error != null) {
        yield LoginFailure(
          error: token.error,
          errorCode: token.errorCode,
        );
      } else {
        await userRepository.persistToken(token);
        yield LoginSuccess();
      }
      //Todo remove it after testing
      yield const LoginFailure(
        error: Strings.somethingWentWrong,
        errorCode: 500,
      );
    }
  }
}
