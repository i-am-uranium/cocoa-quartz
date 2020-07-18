import '../models/models.dart';
import '../network/network.dart';
import '../utils/utils.dart';

class MemberApi {
  static const _apiVersion = 'v1';

  Future<Token> createAccount(CreateMemberRequest request) async {
    Token response;
    await Future.delayed(const Duration(seconds: 2), () {
      response = Token(
        accessToken: 'accessToken',
        tokenType: 'tokenType',
        expiresAt: 71237012830128,
        refreshToken: 'expiresAt',
      );
    });
    return response;
    try {
      final response = await dio.post(
        '/$_apiVersion/members',
        data: request.toJson(),
      );
      return Token(
        accessToken: 'accessToken',
        tokenType: 'tokenType',
        expiresAt: 71237012830128,
        refreshToken: 'expiresAt',
      );
    } on Exception catch (error, stacktrace) {
      return Token(
          error: DioErrorUtil.getError(error, stacktrace),
          errorCode: DioErrorUtil.getErrorCode(error));
    }
  }
}
