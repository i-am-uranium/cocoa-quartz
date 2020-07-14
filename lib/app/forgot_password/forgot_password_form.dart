import 'package:flutter/material.dart';

import '../../constants/constant.dart';
import '../../utils/utils.dart';
import '../common/logo.dart';
import '../common/raised_button.dart';
import '../common/vertical_spacer.dart';
import '../onboarding/onboarding_form_field.dart';
import '../onboarding/onboarding_left_view.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({Key key}) : super(key: key);

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final TextEditingController _emailTextController = TextEditingController();
  String _recoveryEmail;
  @override
  void initState() {
    super.initState();
    _emailTextController.addListener(
        () => setState(() => _recoveryEmail = _emailTextController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: AppColors.onboardingFormBG,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: OnboardingFormLeftView(
                imageWidth: MediaQuery.of(context).size.width * .6,
                imageHeight: MediaQuery.of(context).size.height,
                buttonWidth: MediaQuery.of(context).size.width * .3 - 88,
                onButtonClick: () => Navigator.of(context).pop(),
                buttonTitle: Strings.signIn,
                imageAssets: Assets.forgotPasswordBGPng,
                title: Strings.rememberPassword,
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              color: AppColors.white,
              width: MediaQuery.of(context).size.width * .4,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.only(
                top: 140,
                left: 100,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppLogo(),
                  const VerticalSpacer(
                    space: 24,
                  ),
                  Text(
                    Strings.passwordRecovery,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w300,
                      color: AppColors.black.withOpacity(.8),
                      letterSpacing: .5,
                    ),
                  ),
                  const VerticalSpacer(
                    space: 16,
                  ),
                  const Text(
                    Strings.enterEmailToReceiveYourPassword,
                    style: TextStyle(
                      color: AppColors.grey,
                      letterSpacing: .5,
                    ),
                  ),
                  const VerticalSpacer(
                    space: 32,
                  ),
                  OnboardingFormTextField(
                    width: MediaQuery.of(context).size.width * .3 - 88,
                    height: 64,
                    hint: Strings.recoveryEmailHint,
                    label: Strings.emailLabel,
                    controller: _emailTextController,
                  ),
                  const VerticalSpacer(
                    space: 24,
                  ),
                  OnboardingFormRaisedButton(
                    width: MediaQuery.of(context).size.width * .3 - 88,
                    onClick:
                        _recoveryEmail != null && _recoveryEmail.isValidEmail()
                            ? _handleRecoverPasswordButtonClick
                            : null,
                    text: Strings.send,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 64,
            left: MediaQuery.of(context).size.width * .6 + 32,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.black.withOpacity(.8),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }

  void _handleRecoverPasswordButtonClick() {
    logger.i('_handleRecoverPasswordButtonClick clicked');
  }
}
