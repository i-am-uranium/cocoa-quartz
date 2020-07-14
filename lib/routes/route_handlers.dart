part of 'application.dart';

final _loginPage = LoginPage(
  userRepository: UserRepository(AuthApi()),
);

const _forgotPasswordPage = ForgotPasswordPage();

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
