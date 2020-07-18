import 'dart:html';

import 'package:guard/guard.dart';
import 'package:key_value_store_web/key_value_store_web.dart';

import 'constants/local_storage_constant.dart';

class WebLocalStorageHelper {
  factory WebLocalStorageHelper() => _singleton;
  WebLocalStorageHelper._internal();
  static final _singleton = WebLocalStorageHelper._internal();

  final _kvs = WebKeyValueStore(window.localStorage);

  void clearLocalStorage() {
    _kvs.clear();
  }

  void saveInternetState({bool available}) {
    _kvs.setBool(LocalStorage.internetStateKey, available);
  }

  bool getInternetState() {
    return _kvs.getBool(LocalStorage.internetStateKey);
  }

  void saveLoginState({bool login}) {
    _kvs.setBool(LocalStorage.logInStateKey, login);
  }

  bool getLoginState() {
    return _kvs.getBool(LocalStorage.logInStateKey);
  }

  void saveAccessToken(String token) {
    _kvs.setString(LocalStorage.accessTokenKey, token);
  }

  String getAccessToken() {
    return _kvs.getString(LocalStorage.accessTokenKey);
  }

  void saveRefreshToken(String refreshToken) {
    _kvs.setString(LocalStorage.refreshTokenKey, refreshToken);
  }

  String getRefreshToken() {
    return _kvs.getString(LocalStorage.refreshTokenKey);
  }

  void saveTokenExpiryTime(int timestamp) {
    _kvs.setInt(LocalStorage.tokenExpiryKey, timestamp);
  }

  int getTokenExpiryTime() {
    return guard(() => _kvs.getInt(LocalStorage.tokenExpiryKey), null);
  }
}
