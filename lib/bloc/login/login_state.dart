part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginFailure extends LoginState {
  const LoginFailure({
    @required this.error,
    this.errorCode,
  });
  final String error;
  final int errorCode;

  @override
  List<Object> get props => [error, errorCode];

  @override
  String toString() => 'LoginFailure { error: $error, errorCode:$errorCode }';
}

class LoginSuccess extends LoginState {}
