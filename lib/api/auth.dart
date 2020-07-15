import 'package:dio/dio.dart';

import '../env/config_base.dart';
import '../models/models.dart';
import '../utils/dio_error_util.dart';

class AuthApi {
  AuthApi() {
    _dio.options.contentType = 'application/x-www-form-urlencoded';
    _dio.options.baseUrl = '${AppConfig.authEndpoint}/$_apiVersion';
    _dio.interceptors.add(LogInterceptor());
  }

  static const _apiVersion = 'v1';

  final _dio = Dio();

  Future<Token> generateToken(TokenRequest tokenRequest) async {
    Token token;
    await Future.delayed(const Duration(seconds: 2), () {
      token = Token(
        accessToken: 'accessToken',
        tokenType: 'tokenType',
        expiresAt: 71237012830128,
        refreshToken: 'expiresAt',
      );
    });
    return token;
    try {
      final response = await _dio.post(
        '/oauth/token',
        data: tokenRequest.toJson(),
      );
      return Token.fromJson(response.data);
    } on Exception catch (error, stacktrace) {
      return Token(
          error: DioErrorUtil.getError(error, stacktrace),
          errorCode: DioErrorUtil.getErrorCode(error));
    }
  }

  Future<Token> generateTokenFromRefreshToken(
      RefreshTokenRequest request) async {
    Token token;
    await Future.delayed(const Duration(seconds: 2), () {
      token = Token(
        accessToken: 'accessToken',
        tokenType: 'tokenType',
        expiresAt: 71237012830128,
        refreshToken: 'expiresAt',
      );
    });
    return token;
    try {
      final response = await _dio.post(
        '/oauth/token',
        data: request.toJson(),
      );
      return Token.fromJson(response.data);
    } on Exception catch (error, stacktrace) {
      return Token(
          error: DioErrorUtil.getError(error, stacktrace),
          errorCode: DioErrorUtil.getErrorCode(error));
    }
  }

  Future<GenericResponse> recoverPassword(String email) async {
    GenericResponse response;
    await Future.delayed(const Duration(seconds: 2), () {
      response = GenericResponse(success: true);
    });
    return response;
    try {
      final response = await _dio.post(
        '/users/$email/recover_password',
      );
      return GenericResponse.fromJson(response.data);
    } on Exception catch (error, stacktrace) {
      return GenericResponse(
          error: DioErrorUtil.getError(error, stacktrace),
          errorCode: DioErrorUtil.getErrorCode(error));
    }
  }
}
