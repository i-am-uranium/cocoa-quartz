import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_request.g.dart';

@JsonSerializable(nullable: false)
class RefreshTokenRequest {
  RefreshTokenRequest({
    @required this.clientId,
    @required this.clientSecret,
    @required this.grantType,
    @required this.refreshToken,
  });

  factory RefreshTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRequestFromJson(json);

  @JsonKey(name: 'grant_type')
  final String grantType;
  @JsonKey(name: 'client_id')
  final String clientId;
  @JsonKey(name: 'client_secret')
  final String clientSecret;
  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  Map<String, dynamic> toJson() => _$RefreshTokenRequestToJson(this);
}
