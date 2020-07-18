import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../repository/repository.dart';
import 'create_new_account_form.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({
    @required this.memberRepository,
    @required this.authRepository,
    Key key,
  }) : super(key: key);
  static const String route = 'new-account';
  final MemberRepository memberRepository;
  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: ScreenTypeLayout(
          mobile: DesktopCreateNewAccountForm(
            memberRepository: memberRepository,
            authRepository: authRepository,
          ),
          desktop: DesktopCreateNewAccountForm(
            memberRepository: memberRepository,
            authRepository: authRepository,
          ),
        ),
      ),
    );
  }
}
