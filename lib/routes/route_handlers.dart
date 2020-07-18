part of 'application.dart';

final _loginPage = LoginPage(
  authRepository: AuthRepository(AuthApi()),
);

final _forgotPasswordPage = ForgotPasswordPage(
  authRepository: AuthRepository(AuthApi()),
);

final _createNewAccountPage = CreateAccountPage(
  memberRepository: MemberRepository(MemberApi()),
);

Handler rootHandler = Handler(handlerFunc: (context, params) {
  if (WebLocalStorageHelper().getLoginState()) {
    //todo: return home page
    return _loginPage;
  }
  return _loginPage;
});

Handler loginHandler = Handler(handlerFunc: (context, params) => _loginPage);
Handler forgotPasswordPageHandler =
    Handler(handlerFunc: (context, params) => _forgotPasswordPage);

Handler createAccountPageHandler =
    Handler(handlerFunc: (context, params) => _createNewAccountPage);
