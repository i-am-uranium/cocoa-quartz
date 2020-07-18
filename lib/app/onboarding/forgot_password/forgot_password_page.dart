import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../repository/repository.dart';
import 'forgot_password_form.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({
    @required this.authRepository,
    Key key,
  }) : super(key: key);
  static const String route = 'forgot-password';
  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: ScreenTypeLayout(
          mobile: ForgotPasswordForm(
            authRepository: authRepository,
          ),
          desktop: ForgotPasswordForm(
            authRepository: authRepository,
          ),
        ),
      ),
    );
  }
}
