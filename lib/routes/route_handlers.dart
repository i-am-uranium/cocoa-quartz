part of 'application.dart';

final _loginPage = LoginPage(
  authRepository: AuthRepository(
    AuthApi(),
    WebLocalStorageHelper(),
  ),
);

final _forgotPasswordPage = ForgotPasswordPage(
  authRepository: AuthRepository(
    AuthApi(),
    WebLocalStorageHelper(),
  ),
);

final _createNewAccountPage = CreateAccountPage(
  memberRepository: MemberRepository(MemberApi()),
  authRepository: AuthRepository(
    AuthApi(),
    WebLocalStorageHelper(),
  ),
);

const _homePage = HomePage();
bool get _isLoggedIn => WebLocalStorageHelper().getLoginState();

Handler rootHandler = Handler(
    handlerFunc: (context, params) => _isLoggedIn ? _homePage : _loginPage);

Handler loginHandler = Handler(
    handlerFunc: (context, params) => _isLoggedIn ? _homePage : _loginPage);

Handler forgotPasswordPageHandler = Handler(
    handlerFunc: (context, params) =>
        _isLoggedIn ? _homePage : _forgotPasswordPage);

Handler createAccountPageHandler = Handler(
    handlerFunc: (context, params) =>
        _isLoggedIn ? _homePage : _createNewAccountPage);

Handler homePageHandler = Handler(
  handlerFunc: (context, params) => _isLoggedIn ? _homePage : _loginPage,
);
