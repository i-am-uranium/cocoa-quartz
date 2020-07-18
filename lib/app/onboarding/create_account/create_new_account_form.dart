import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_dashboard/app/home/home_page.dart';

import '../../../bloc/bloc.dart';
import '../../../constants/constant.dart';
import '../../../repository/repository.dart';
import '../../../routes/application.dart';
import '../../../utils/logger.dart';
import '../../common/common.dart';
import '../back_icon_button.dart';
import '../error_bar.dart';
import '../onboarding.dart';
import '../onboarding_form_field.dart';
import '../onboarding_left_view.dart';
import '../raised_button.dart';

class DesktopCreateNewAccountForm extends StatefulWidget {
  const DesktopCreateNewAccountForm({
    @required this.memberRepository,
    @required this.authRepository,
    Key key,
  }) : super(key: key);

  final MemberRepository memberRepository;
  final AuthRepository authRepository;

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

  CreateAccountBloc _createAccountBloc;

  @override
  void initState() {
    super.initState();
    _createAccountBloc = CreateAccountBloc(
      memberRepository: widget.memberRepository,
      authRepository: widget.authRepository,
    );
    _nameTextController
        .addListener(() => setState(() => _name = _nameTextController.text));
    _emailTextController
        .addListener(() => setState(() => _email = _emailTextController.text));
    _passwordTextController.addListener(
        () => setState(() => _password = _passwordTextController.text));
  }

  @override
  void dispose() {
    _createAccountBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _createAccountBloc),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<InternetConnectionBloc, InternetConnectionState>(
            listener: (context, state) => _handelInternetStateChange(state),
          ),
          BlocListener<CreateAccountBloc, CreateAccountState>(
            listener: (context, state) =>
                _handleCreateAccountStateChange(state),
          ),
        ],
        child: BlocBuilder<CreateAccountBloc, CreateAccountState>(
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
                          showActivityIndicator:
                              state is CreateAccountInProgress,
                        ),
                        const VerticalSpacer(
                          space: 24,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 64,
                  left: MediaQuery.of(context).size.width * .6 + 32,
                  child: BackIconButton(
                    onPressed: () => Application.router.navigateTo(
                      context,
                      LoginPage.route,
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

  void _handleCreateAccountStateChange(CreateAccountState state) {
    if (state is CreateAccountSuccess) {
      Application.router.navigateTo(
        context,
        HomePage.route,
      );
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

  void _handleSignInButtonClick() {
    Application.router.navigateTo(
      context,
      LoginPage.route,
    );
  }

  void _handleCreateNewAccount() {
    logger.i('Create new account clicked');
    _createAccountBloc.add(
      CreateAccountButtonPressed(
        email: _email,
        fullName: _name,
        password: _password,
      ),
    );
  }
}
