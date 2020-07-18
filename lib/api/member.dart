import '../models/models.dart';
import '../network/network.dart';
import '../utils/utils.dart';

class MemberApi {
  static const _apiVersion = 'v1';

  Future<GenericResponse> createAccount(CreateMemberRequest request) async {
    GenericResponse response;
    await Future.delayed(const Duration(seconds: 2), () {
      response = GenericResponse(success: true);
    });
    return response;
    try {
      final response = await dio.post(
        '/$_apiVersion/members',
        data: request.toJson(),
      );
      return GenericResponse(
          success: successRange
              .contains(response != null ? response.statusCode : 0));
    } on Exception catch (error, stacktrace) {
      return GenericResponse(
          success: false,
          error: DioErrorUtil.getError(error, stacktrace),
          errorCode: DioErrorUtil.getErrorCode(error));
    }
  }
}
