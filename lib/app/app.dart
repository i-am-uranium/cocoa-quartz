import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import '../constants/constant.dart';
import '../routes/application.dart';
import '../utils/utils.dart';

class ModalApp extends StatefulWidget {
  const ModalApp({Key key}) : super(key: key);

  @override
  _ModalAppState createState() => _ModalAppState();
}

class _ModalAppState extends State<ModalApp> {
  final _internetConnectionBloc = InternetConnectionBloc()
    ..add(InternetConnected());

  @override
  void initState() {
    super.initState();
    _initRouter();
    _subscriberForConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _internetConnectionBloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Strings.appName,
        theme: AppTheme.theme,
        initialRoute: Routes.root,
        onGenerateRoute: Application.router.generator,
        navigatorObservers: [Application.routeObserver],
      ),
    );
  }

  void _initRouter() {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  void _subscriberForConnectivity() {
    SystemUtils.subscriberForConnectivity(
      onOnline: (event) => _internetConnectionBloc.add(InternetConnected()),
      onOffline: (event) => _internetConnectionBloc.add(InternetDisconnected()),
    );
  }
}
