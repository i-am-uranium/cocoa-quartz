import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'create_new_account_form.dart';

class CreateNewAccountPage extends StatelessWidget {
  const CreateNewAccountPage({Key key}) : super(key: key);
  static const String route = 'new-account';
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: ScreenTypeLayout(
          mobile: const DesktopCreateNewAccountForm(),
          desktop: const DesktopCreateNewAccountForm(),
        ),
      ),
    );
  }
}
