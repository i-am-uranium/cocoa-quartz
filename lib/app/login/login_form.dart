import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/api.dart';
import '../../bloc/internet/connection_bloc.dart';
import '../../bloc/login/login_bloc.dart';
import '../../constants/colors.dart';
import '../../constants/constant.dart';
import '../../repository/user.dart';
import '../../utils/utils.dart';
import '../common/custom_container.dart';
import '../common/horizontal_spacer.dart';
import '../common/logo.dart';
import '../common/vertical_spacer.dart';

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
      child: BlocListener<InternetConnectionBloc, InternetConnectionState>(
        listener: (context, state) => _handelInternetStateChange(state),
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) => Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: AppColors.loginFormBG,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Image.asset(
                    Assets.loginBGPng,
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
                        Row(
                          children: [
                            const AppLogo(),
                            const HorizontalSpacer(
                              space: 16,
                            ),
                            Text(
                              Strings.appName,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w300,
                                color: AppColors.black.withOpacity(.8),
                                letterSpacing: .5,
                              ),
                            ),
                          ],
                        ),
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
                        LoginFormTextField(
                          width: MediaQuery.of(context).size.width * .3 - 88,
                          height: 64,
                          hint: Strings.emailHint,
                          label: Strings.emailLabel,
                          controller: _emailTextController,
                        ),
                        const VerticalSpacer(
                          space: 16,
                        ),
                        LoginFormTextField(
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
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .3 - 88,
                          height: 46,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 2,
                            onPressed:
                                _isValidInput ? _handleLoginButtonClick : null,
                            child: const Text(
                              Strings.signIn,
                              style: TextStyle(color: AppColors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool get _isValidInput {
    return _email != null &&
        _email.isValidEmail() &&
        _password != null &&
        _password.isNotEmpty;
  }

  void _handleForgotPasswordButtonClick() {
    logger.d('Forgot password button clicked.');
  }

  void _handleLoginButtonClick() {
    logger.d('Email and password are: $_email $_password');
    _loginBloc.add(LoginButtonPressed(email: _email, password: _password));
  }

  void _handelInternetStateChange(InternetConnectionState state) {
    logger.d('Internet state changed to $state');
  }
}

class LoginFormTextField extends StatelessWidget {
  const LoginFormTextField({
    @required this.width,
    @required this.height,
    @required this.label,
    @required this.hint,
    this.obscureText = false,
    this.controller,
    Key key,
  }) : super(key: key);
  final double width;
  final double height;
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Center(
        child: CustomContainer(
          color: AppColors.mainBG,
          shadowColor: AppColors.loginFormBG,
          child: TextFormField(
            controller: controller,
            keyboardType:
                obscureText ? TextInputType.text : TextInputType.emailAddress,
            cursorColor: AppColors.primary,
            obscureText: obscureText,
            decoration: InputDecoration(
              labelText: label,
              contentPadding: const EdgeInsets.only(
                left: 16,
              ),
              hintText: hint,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
