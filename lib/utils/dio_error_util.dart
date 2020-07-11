import 'package:dio/dio.dart';

import '../constants/strings.dart';
import 'logger.dart';

class DioErrorUtil {
  DioErrorUtil._();

  static int getErrorCode(dynamic error) {
    if (error is DioError) {
      return error.response?.statusCode;
    }
    return -1;
  }

  static String getError(dynamic error, StackTrace stacktrace) {
    String message = Strings.somethingWentWrong;
    final _error = {'error': error};
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.CANCEL:
          message = Strings.requestToApiServerCancelled;
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          message = Strings.connectionTimeoutWithServer;
          break;
        case DioErrorType.DEFAULT:
          message = Strings.somethingWentWrong;
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          message = Strings.receivedTimeoutInConnectionWithServer;
          break;
        case DioErrorType.RESPONSE:
          _error['request'] = error.request;
          if (error != null &&
              error.response != null &&
              error.response.data != null) {
            if (error.response.data is Map) {
              message = error.response.data['message'];
            } else if (error.response.data is String) {
              message = error.response.data;
            }
          }
          break;
        case DioErrorType.SEND_TIMEOUT:
          message = Strings.sendTimeoutWithServer;
          break;
      }
    } else {
      message = Strings.unexpectedErrorOccurred;
    }
    logger.e(message, error, stacktrace);
    return message;
  }
}
