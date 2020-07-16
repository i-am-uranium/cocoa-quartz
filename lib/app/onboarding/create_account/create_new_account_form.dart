import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_dashboard/app/onboarding/onboarding.dart';

import '../../../api/api.dart';
import '../../../bloc/bloc.dart';
import '../../../constants/constant.dart';
import '../../../repository/repository.dart';
import '../../../routes/application.dart';
import '../../../utils/logger.dart';
import '../../common/common.dart';
import '../error_bar.dart';
import '../forgot_password/forgot_password_page.dart';
import '../onboarding_form_field.dart';
import '../onboarding_left_view.dart';
import '../raised_button.dart';

class DesktopCreateNewAccountForm extends StatefulWidget {
  const DesktopCreateNewAccountForm({
    Key key,
  }) : super(key: key);

  @override
  _DesktopCreateNewAccountFormState createState() =>
      _DesktopCreateNewAccountFormState();
}

class _DesktopCreateNewAccountFormState
    extends State<DesktopCreateNewAccountForm> {
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  String _name;
  String _email;
  String _password;
  double _errorToastHeight = 0;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _nameTextController
        .addListener(() => setState(() => _name = _nameTextController.text));
    _emailTextController
        .addListener(() => setState(() => _email = _emailTextController.text));
    _passwordTextController.addListener(
        () => setState(() => _password = _passwordTextController.text));
  }

  final LoginBloc _loginBloc = LoginBloc(
    userRepository: UserRepository(AuthApi()),
  );

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _loginBloc),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<InternetConnectionBloc, InternetConnectionState>(
            listener: (context, state) => _handelInternetStateChange(state),
          ),
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) => _handleLoginStateChange(state),
          ),
        ],
        child: BlocBuilder<LoginBloc, LoginState>(
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
                    color: AppColors.onboardingFormBG,
                    height: MediaQuery.of(context).size.height,
                    child: OnboardingFormLeftView(
                      imageWidth: MediaQuery.of(context).size.width * .6,
                      imageHeight: MediaQuery.of(context).size.height,
                      buttonWidth: MediaQuery.of(context).size.width * .3 - 88,
                      onButtonClick: _handleSignInButtonClick,
                      buttonTitle: Strings.signIn,
                      imageAssets: Assets.createAccountBGPng,
                      title: Strings.alreadyHaveAnAccount,
                      titleTextColor: AppColors.white,
                      buttonColor: AppColors.white,
                      buttonTextColor: AppColors.black.withOpacity(.8),
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
                          Strings.createAnAccount,
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
                          Strings.signUpToContinue,
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
                          hint: Strings.nameHint,
                          label: Strings.nameLabel,
                          controller: _nameTextController,
                          textInputType: TextInputType.name,
                        ),
                        const VerticalSpacer(
                          space: 16,
                        ),
                        OnboardingFormTextField(
                          width: MediaQuery.of(context).size.width * .3 - 88,
                          height: 64,
                          hint: Strings.emailHint,
                          label: Strings.emailHint,
                          controller: _emailTextController,
                        ),
                        const VerticalSpacer(),
                        OnboardingFormTextField(
                          width: MediaQuery.of(context).size.width * .3 - 88,
                          height: 64,
                          hint: Strings.passwordHint,
                          label: Strings.passwordLabel,
                          obscureText: true,
                          controller: _passwordTextController,
                        ),
                        const VerticalSpacer(
                          space: 24,
                        ),
                        OnboardingFormRaisedButton(
                          width: MediaQuery.of(context).size.width * .3 - 88,
                          onClick:
                              _isValidInput ? _handleCreateNewAccount : null,
                          text: Strings.signUp,
                          showActivityIndicator: state is LoginInProgress,
                        ),
                        const VerticalSpacer(
                          space: 24,
                        ),
                      ],
                    ),
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

  void _handleSnackbarClose() {
    setState(() {
      _errorToastHeight = 0;
      _errorMessage = '';
    });
  }

  void _handleLoginStateChange(LoginState state) {
    if (state is LoginFailure) {
      setState(() {
        _errorToastHeight = 64;
        _errorMessage = state.error;
      });
    }
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

  bool get _isValidInput {
    return _name != null &&
        _name.isNotEmpty &&
        _email != null &&
        _email.isValidEmail() &&
        _password != null &&
        _password.isNotEmpty;
  }

  void _handleSignInButtonClick() => Application.router.navigateTo(
        context,
        LoginPage.route,
      );

  void _handleCreateNewAccount() {
    logger.i('Create new account clicked');
  }
}
