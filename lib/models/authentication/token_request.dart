import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token_request.g.dart';

@JsonSerializable(nullable: false)
class TokenRequest {
  TokenRequest({
    @required this.phone,
    @required this.password,
    @required this.clientId,
    @required this.clientSecret,
    @required this.grantType,
  });

  factory TokenRequest.fromJson(Map<String, dynamic> json) =>
      _$TokenRequestFromJson(json);

  @JsonKey(name: 'phone_number')
  final String phone;
  final String password;
  @JsonKey(name: 'client_id')
  final String clientId;
  @JsonKey(name: 'client_secret')
  final String clientSecret;
  @JsonKey(name: 'grant_type')
  final String grantType;

  Map<String, dynamic> toJson() => _$TokenRequestToJson(this);
}
