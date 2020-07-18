import '../api/api.dart';

import '../models/models.dart';

class MemberRepository {
  MemberRepository(this.memberApi);
  final MemberApi memberApi;

  Future<GenericResponse> createAccount(CreateMemberRequest request) async {
    final response = await memberApi.createAccount(request);
    return response;
  }
}
