import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_member_request.g.dart';

@JsonSerializable(nullable: false)
class CreateMemberRequest {
  CreateMemberRequest(
      {@required this.fullName, @required this.email, @required this.password});

  factory CreateMemberRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateMemberRequestFromJson(json);

  @JsonKey(name: 'full_name')
  final String fullName;
  final String email;
  final String password;

  Map<String, dynamic> toJson() => _$CreateMemberRequestToJson(this);
}
