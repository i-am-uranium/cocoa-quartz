import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../repository/repository.dart';
import 'login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    @required this.userRepository,
    Key key,
  })  : assert(userRepository != null, 'userRepository cannot be null'),
        super(key: key);

  static const String route = 'login';

  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: ScreenTypeLayout(
          mobile: const DesktopLoginForm(),
          desktop: const DesktopLoginForm(),
        ),
      ),
    );
  }
}
