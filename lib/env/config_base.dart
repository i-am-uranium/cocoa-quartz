import 'config.dart';
import 'dev.dart';

class AppConfig {
  AppConfig._();

  static final Config _config = Config.fromJson(devConfig);
  static String get authEndpoint => _config.authEndpoint;
  static String get serviceEndpoint => _config.serviceEndpoint;
  static String get env => _config.env;
}
