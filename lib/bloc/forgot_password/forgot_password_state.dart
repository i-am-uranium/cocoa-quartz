part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();
  @override
  List<Object> get props => [];
}

class RecoverPasswordUnInitiated extends ForgotPasswordState {}

class RecoverPasswordInitiated extends ForgotPasswordState {}

class RecoverPasswordFailed extends ForgotPasswordState {
  const RecoverPasswordFailed({
    @required this.error,
    this.errorCode,
  });
  final String error;
  final int errorCode;

  @override
  List<Object> get props => [error, errorCode];

  @override
  String toString() =>
      'PasswordRecoveryEmailFailed { error: $error, errorCode:$errorCode }';
}

class RecoverPasswordSuccess extends ForgotPasswordState {}
