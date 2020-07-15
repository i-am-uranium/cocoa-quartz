part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();
}

class RecoverPassword extends ForgotPasswordEvent {
  const RecoverPassword({
    @required this.email,
  });

  final String email;

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'RecoverPassword { email: $email }';
}
