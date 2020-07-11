import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app.dart';
import 'utils/logger.dart';
import 'utils/utils.dart';

class CustomBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    logger.d(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logger.d(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    logger.e(error);
  }
}

void _initEssentialServices() {
  if (SystemUtils().isInDebugMode) {
    BlocSupervisor.delegate = CustomBlocDelegate();
  }
}

Future<void> main() async {
  _initEssentialServices();
  runApp(const ModalApp());
}
