import '../api/api.dart';

import '../data/data.dart';
import '../models/models.dart';

class AuthRepository {
  AuthRepository(this.authApi);
  final AuthApi authApi;
  final _webLocalStorage = WebLocalStorageHelper();

  Future<Token> generateToken(String phone, String password) async {
    final request = TokenRequest(
      phone: phone,
      password: password,
      clientId: 'clientId',
      clientSecret: 'clientSecret',
      grantType: 'password',
    );
    final response = await authApi.generateToken(request);
    return response;
  }

  Future<Token> generateTokenFromRefreshToken(String refreshToken) async {
    final request = RefreshTokenRequest(
        clientId: 'clientId',
        clientSecret: 'clientSecret',
        grantType: 'refresh_token',
        refreshToken: refreshToken);
    final response = await authApi.generateTokenFromRefreshToken(request);
    return response;
  }

  Future<void> persistToken(Token token) async {
    //Logic to persist token goes here
  }

  Future<void> deleteToken() async {
    _webLocalStorage.clearLocalStorage();
  }

  Future<GenericResponse> recoverPassword(String email) async {
    final response = await authApi.recoverPassword(email);
    return response;
  }
}
