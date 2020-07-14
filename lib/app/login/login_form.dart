import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/api.dart';
import '../../bloc/internet/connection_bloc.dart';
import '../../bloc/login/login_bloc.dart';
import '../../constants/colors.dart';
import '../../constants/constant.dart';
import '../../repository/user.dart';
import '../../routes/application.dart';
import '../../utils/utils.dart';
import '../common/custom_container.dart';
import '../common/logo.dart';
import '../common/raised_button.dart';
import '../common/vertical_spacer.dart';
import '../forgot_password/forgot_password_page.dart';
import '../onboarding/onboarding_form_field.dart';
import '../onboarding/onboarding_left_view.dart';

class DesktopLoginForm extends StatefulWidget {
  const DesktopLoginForm({
    Key key,
  }) : super(key: key);

  @override
  _DesktopLoginFormState createState() => _DesktopLoginFormState();
}

class _DesktopLoginFormState extends State<DesktopLoginForm> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  String _email;
  String _password;
  bool _showProgressIndicator = false;
  double _errorToastHeight = 0;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
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
                      imageHeight: MediaQuery.of(context).size.height * .7,
                      buttonWidth: MediaQuery.of(context).size.width * .3 - 88,
                      onButtonClick: _handleCreateNewAccount,
                      buttonTitle: Strings.createAnAccount,
                      imageAssets: Assets.loginBGPng,
                      title: Strings.doNotHavenAnAccount,
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
                          Strings.welcomeBack,
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
                          Strings.signInToContinue,
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
                          hint: Strings.emailHint,
                          label: Strings.emailLabel,
                          controller: _emailTextController,
                        ),
                        const VerticalSpacer(
                          space: 16,
                        ),
                        OnboardingFormTextField(
                          width: MediaQuery.of(context).size.width * .3 - 88,
                          height: 64,
                          hint: Strings.passwordHint,
                          label: Strings.passwordLabel,
                          obscureText: true,
                          controller: _passwordTextController,
                        ),
                        const VerticalSpacer(),
                        FlatButton(
                          onPressed: _handleForgotPasswordButtonClick,
                          child: const Text(
                            Strings.forgotPassword,
                            style: TextStyle(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        const VerticalSpacer(
                          space: 24,
                        ),
                        OnboardingFormRaisedButton(
                          width: MediaQuery.of(context).size.width * .3 - 88,
                          onClick: _isValidInput && !_showProgressIndicator
                              ? _handleLoginButtonClick
                              : null,
                          text: Strings.signIn,
                        ),
                        const VerticalSpacer(
                          space: 24,
                        ),
                        SocialLogin(
                          width: MediaQuery.of(context).size.width * .3 - 88,
                          onGoogleButtonClick: _handleGoogleLogin,
                          onFacebookButtonClick: _handleFacebookLogin,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * .5,
                  right: (MediaQuery.of(context).size.width * .4) / 2,
                  child: _showProgressIndicator
                      ? const CupertinoActivityIndicator()
                      : const SizedBox(),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: ErrorSnackBar(
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
      _showProgressIndicator = false;
    });
  }

  void _handleLoginStateChange(LoginState state) {
    if (state is LoginSuccess) {
      setState(() => _showProgressIndicator = false);
      return;
    }
    if (state is LoginFailure) {
      setState(() {
        _errorToastHeight = 64;
        _errorMessage = 'Something went wrong';
        _showProgressIndicator = false;
      });
    }
  }

  void _handelInternetStateChange(InternetConnectionState state) {
    if (state is InternetUnAvailable) {
      setState(() {
        _errorToastHeight = 64;
        _errorMessage = 'Your internet connection appears to be offline';
        _showProgressIndicator = false;
      });
      return;
    }
    if (state is InternetAvailable) {
      _handleSnackbarClose();
      return;
    }
  }

  bool get _isValidInput {
    return _email != null &&
        _email.isValidEmail() &&
        _password != null &&
        _password.isNotEmpty;
  }

  void _handleForgotPasswordButtonClick() {
    Application.router.navigateTo(
      context,
      ForgotPasswordPage.route,
    );
  }

  void _handleLoginButtonClick() {
    _loginBloc.add(LoginButtonPressed(email: _email, password: _password));
    setState(() {
      _showProgressIndicator = true;
    });
  }

  void _handleGoogleLogin() {
    logger.i('google login button clicked');
  }

  void _handleFacebookLogin() {
    logger.i('facebook login button clicked');
  }

  void _handleCreateNewAccount() {
    logger.i('Create new account clicked');
  }
}

class ErrorSnackBar extends StatelessWidget {
  const ErrorSnackBar({
    @required this.width,
    this.height = 0,
    this.message = '',
    this.onCloseButtonClick,
    Key key,
  }) : super(key: key);
  final double width;
  final double height;
  final String message;
  final VoidCallback onCloseButtonClick;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: width,
      height: height,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeIn,
      child: CustomContainer(
        borderRadius: 4,
        shadowColor: AppColors.errorBG,
        child: Stack(
          children: [
            Align(
              child: Text(message),
            ),
            Positioned(
              top: 0,
              right: 16,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: onCloseButtonClick,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SocialLogin extends StatelessWidget {
  const SocialLogin({
    @required this.width,
    this.onGoogleButtonClick,
    this.onFacebookButtonClick,
    Key key,
  }) : super(key: key);
  final double width;
  final VoidCallback onGoogleButtonClick;
  final VoidCallback onFacebookButtonClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: width / 3,
                color: AppColors.lightGrey,
                height: 1,
              ),
              Text(
                'Or Sign In With',
                style: TextStyle(
                  color: AppColors.black.withOpacity(.8),
                  letterSpacing: .18,
                ),
              ),
              Container(
                width: width / 3,
                color: AppColors.lightGrey,
                height: 1,
              )
            ],
          ),
          const VerticalSpacer(
            space: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SocialButton(
                width: width / 2 - 16,
                color: AppColors.socialGoogleButtonBG,
                socialIconAsset: Assets.socialGooglePng,
                onClick: onGoogleButtonClick,
              ),
              SocialButton(
                width: width / 2 - 16,
                color: AppColors.socialFacebookButtonBG,
                socialIconAsset: Assets.socialFacebookPng,
                onClick: onFacebookButtonClick,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  const SocialButton({
    @required this.width,
    @required this.socialIconAsset,
    @required this.color,
    this.onClick,
    Key key,
  }) : super(key: key);
  final String socialIconAsset;
  final VoidCallback onClick;
  final Color color;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 46,
      child: RaisedButton(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 1,
        onPressed: onClick,
        child: Image.asset(
          socialIconAsset,
          width: 21,
          height: 21,
        ),
      ),
    );
  }
}
