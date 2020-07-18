import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/repository.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc({
    @required this.authRepository,
  }) : assert(authRepository != null, 'auth repository cannot be null');

  final AuthRepository authRepository;

  @override
  ForgotPasswordState get initialState => RecoverPasswordUnInitiated();

  @override
  Stream<ForgotPasswordState> mapEventToState(
      ForgotPasswordEvent event) async* {
    yield RecoverPasswordInitiated();
    if (event is RecoverPassword) {
      final response = await authRepository.recoverPassword(event.email);
      if (response.success) {
        yield RecoverPasswordSuccess();
        return;
      }
      yield RecoverPasswordFailed(
          error: response.error, errorCode: response.errorCode);
    }
    return;
  }
}
