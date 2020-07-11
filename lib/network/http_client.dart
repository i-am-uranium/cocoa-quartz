import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

import '../env/config_base.dart';

final List<int> successRange = List<int>.generate(100, (i) => i + 200);

final _baseOption = BaseOptions(
  baseUrl: AppConfig.serviceEndpoint,
  receiveTimeout: 5000,
  connectTimeout: 5000,
);

Dio dio = Dio(_baseOption)
  ..interceptors.add(CookieManager(CookieJar()))
  ..interceptors.add(
    InterceptorsWrapper(
      onRequest: (options) async {
        return _doSomethingBeforeMakingHttpRequest(options);
      },
    ),
  );

Future<Options> _doSomethingBeforeMakingHttpRequest(Options options) async {
  return options;
}
