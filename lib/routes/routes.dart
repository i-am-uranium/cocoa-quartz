part of 'application.dart';

mixin Routes {
  static String root = '/';

  static void configureRoutes(Router router) {
    router
      ..define(
        root,
        handler: loginHandler,
        transitionType: TransitionType.fadeIn,
      )
      ..define(
        LoginPage.route,
        handler: loginHandler,
        transitionType: TransitionType.fadeIn,
      )
      ..notFoundHandler = loginHandler;
  }
}
