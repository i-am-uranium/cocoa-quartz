import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/bloc.dart';
import '../../../constants/constant.dart';
import '../../../repository/repository.dart';
import '../../../utils/logger.dart';
import '../../common/logo_with_text.dart';
import '../../common/vertical_spacer.dart';
import '../back_icon_button.dart';
import '../error_bar.dart';
import '../onboarding_form_field.dart';
import '../onboarding_left_view.dart';
import '../raised_button.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({
    @required this.authRepository,
    Key key,
  }) : super(key: key);
  final AuthRepository authRepository;

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final TextEditingController _emailTextController = TextEditingController();
  ForgotPasswordBloc _forgotPasswordBloc;
  String _recoveryEmail;
  double _errorToastHeight = 0;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _forgotPasswordBloc = ForgotPasswordBloc(
      authRepository: widget.authRepository,
    );
    _emailTextController.addListener(
        () => setState(() => _recoveryEmail = _emailTextController.text));
  }

  @override
  void dispose() {
    _forgotPasswordBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _forgotPasswordBloc),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<InternetConnectionBloc, InternetConnectionState>(
            listener: (context, state) => _handelInternetStateChange(state),
          ),
          BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
            listener: (context, state) =>
                _handleRecoverPasswordStateChange(state),
          ),
        ],
        child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
          builder: (context, state) => Container(
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
                        const AppLogoWithText(),
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
                          onClick: _recoveryEmail != null &&
                                  _recoveryEmail.isValidEmail()
                              ? _handleRecoverPasswordButtonClick
                              : null,
                          text: Strings.send,
                          showActivityIndicator:
                              state is RecoverPasswordInitiated,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 64,
                  left: MediaQuery.of(context).size.width * .6 + 32,
                  child: BackIconButton(
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: ErrorBar(
                    width: MediaQuery.of(context).size.width,
                    height: _errorToastHeight,
                    message: _errorMessage,
                    onCloseButtonClick: _handleSnackbarClose,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleRecoverPasswordButtonClick() {
    logger.i('_handleRecoverPasswordButtonClick clicked');
    _forgotPasswordBloc.add(RecoverPassword(email: _recoveryEmail));
  }

  void _handelInternetStateChange(InternetConnectionState state) {
    if (state is InternetUnAvailable) {
      setState(() {
        _errorToastHeight = 64;
        _errorMessage = Strings.internetNotAvailable;
      });
      return;
    }
    if (state is InternetAvailable) {
      _handleSnackbarClose();
      return;
    }
  }

  void _handleSnackbarClose() {
    setState(() {
      _errorToastHeight = 0;
      _errorMessage = '';
    });
  }

  void _handleRecoverPasswordStateChange(ForgotPasswordState state) {
    logger.i('state is $state');
    if (state is RecoverPasswordFailed) {
      setState(() {
        _errorToastHeight = 0;
        _errorMessage = state.error;
      });
    }
  }
}
