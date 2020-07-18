part of 'create_account_bloc.dart';

abstract class CreateAccountEvent extends Equatable {
  const CreateAccountEvent();
}

class CreateAccountButtonPressed extends CreateAccountEvent {
  const CreateAccountButtonPressed({
    @required this.fullName,
    @required this.email,
    @required this.password,
  });

  final String fullName;
  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];

  @override
  String toString() =>
      '''CreateAccountButtonPressed { fullName: $fullName, email: $email, password:$password  }''';
}
