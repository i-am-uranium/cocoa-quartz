import 'dart:core';
import 'package:json_annotation/json_annotation.dart';

import '../member.dart';
part 'token.g.dart';

@JsonSerializable(nullable: false)
class Token {
  Token({
    this.accessToken,
    this.tokenType,
    this.expiresAt,
    this.refreshToken,
    this.user,
    this.error,
    this.errorCode,
  });

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  @JsonKey(name: 'access_token')
  final String accessToken;
  @JsonKey(name: 'token_type')
  final String tokenType;
  @JsonKey(name: 'expires_at')
  final int expiresAt;
  @JsonKey(name: 'refresh_token')
  final String refreshToken;
  @JsonKey(name: 'user')
  final Member user;

  @JsonKey(ignore: true)
  String error;
  @JsonKey(ignore: true)
  int errorCode;

  Map<String, dynamic> toJson() => _$TokenToJson(this);
}
