import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'otp_request.g.dart';

@JsonSerializable(nullable: false)
class OTPRequest {
  OTPRequest(
      {@required this.mobile,
      @required this.clientId,
      @required this.clientSecret});

  factory OTPRequest.fromJson(Map<String, dynamic> json) =>
      _$OTPRequestFromJson(json);

  final String mobile;
  @JsonKey(name: 'client_id')
  final String clientId;
  @JsonKey(name: 'client_secret')
  final String clientSecret;

  Map<String, dynamic> toJson() => _$OTPRequestToJson(this);
}
