import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../repository/repository.dart';
import 'login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    @required this.authRepository,
    Key key,
  })  : assert(authRepository != null, 'auth repository cannot be null'),
        super(key: key);

  static const String route = 'login';

  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: ScreenTypeLayout(
          mobile: DesktopLoginForm(
            authRepository: authRepository,
          ),
          desktop: DesktopLoginForm(
            authRepository: authRepository,
          ),
        ),
      ),
    );
  }
}
