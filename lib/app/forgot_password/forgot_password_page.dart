import 'package:flutter/material.dart';
import 'forgot_password_form.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key key}) : super(key: key);
  static const String route = 'forgot-password';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ForgotPasswordForm(),
    );
  }
}
