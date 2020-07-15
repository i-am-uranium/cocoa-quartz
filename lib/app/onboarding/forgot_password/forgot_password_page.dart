import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'forgot_password_form.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key key}) : super(key: key);
  static const String route = 'forgot-password';
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: ScreenTypeLayout(
          mobile: const ForgotPasswordForm(),
          desktop: const ForgotPasswordForm(),
        ),
      ),
    );
  }
}
