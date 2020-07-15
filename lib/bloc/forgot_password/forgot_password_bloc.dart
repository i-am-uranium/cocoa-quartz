import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/repository.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc({
    @required this.userRepository,
  }) : assert(userRepository != null, 'partnerRepository cannot be null');

  final UserRepository userRepository;

  @override
  ForgotPasswordState get initialState => RecoverPasswordUnInitiated();

  @override
  Stream<ForgotPasswordState> mapEventToState(
      ForgotPasswordEvent event) async* {
    yield RecoverPasswordInitiated();
    if (event is RecoverPassword) {
      final response = await userRepository.recoverPassword(event.email);
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
