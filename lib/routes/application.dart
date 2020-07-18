import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:modal_dashboard/app/home/home_page.dart';

import '../api/api.dart';
import '../app/onboarding/onboarding.dart';
import '../data/data.dart';
import '../repository/repository.dart';

part 'route_handlers.dart';
part 'routes.dart';

class Application {
  Application._();
  static Router router;
  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();
}
