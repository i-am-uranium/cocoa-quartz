part of 'create_account_bloc.dart';

abstract class CreateAccountState extends Equatable {
  const CreateAccountState();

  @override
  List<Object> get props => [];
}

class CreateAccountInitial extends CreateAccountState {}

class CreateAccountInProgress extends CreateAccountState {}

class CreateAccountFailure extends CreateAccountState {
  const CreateAccountFailure({
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

class CreateAccountSuccess extends CreateAccountState {}
