import '../api/api.dart';

import '../data/data.dart';
import '../models/models.dart';

class AuthRepository {
  AuthRepository(this.authApi, this.webLocalStorage);
  final AuthApi authApi;
  final WebLocalStorageHelper webLocalStorage;

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
    webLocalStorage
      ..saveAccessToken(token.accessToken)
      ..saveRefreshToken(token.refreshToken)
      ..saveTokenExpiryTime(token.expiresAt);
  }

  Future<void> persistLogInState({bool loggedIn}) async {
    webLocalStorage.saveLoginState(login: loggedIn);
  }

  Future<void> deleteToken() async {
    webLocalStorage.clearLocalStorage();
  }

  Future<GenericResponse> recoverPassword(String email) async {
    final response = await authApi.recoverPassword(email);
    return response;
  }
}
