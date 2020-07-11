import 'dart:html' as html;
import 'package:flutter/material.dart';

import '../constants/constant.dart';
import '../env/config_base.dart';

class SystemUtils {
  factory SystemUtils() {
    return _singleton;
  }
  SystemUtils._internal();
  static final SystemUtils _singleton = SystemUtils._internal();

  bool get isInDebugMode {
    return AppConfig.env == Strings.dev;
  }

  static _AlwaysDisabledFocusNode get alwaysDisabledFocusNode =>
      _AlwaysDisabledFocusNode();

  static void subscriberForConnectivity(
      {Function onOnline, Function onOffline}) {
    html.window.addEventListener('online', onOnline);
    html.window.addEventListener('offline', onOffline);
  }
}

class _AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
