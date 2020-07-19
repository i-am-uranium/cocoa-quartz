import 'package:json_annotation/json_annotation.dart';

part 'member.g.dart';

@JsonSerializable(nullable: false)
class Member {
  Member({
    this.id,
    this.firstName,
    this.lastName,
    this.gender,
    this.email,
    this.status,
    this.username,
    this.avatar,
    this.error,
    this.errorCode,
  });

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  final String id;
  @JsonKey(name: 'first_name')
  final String firstName;

  @JsonKey(name: 'last_name')
  final String lastName;

  final String gender;

  final String email;
  final String username;
  final String avatar;

  final String status;

  @JsonKey(ignore: true)
  String error;
  @JsonKey(ignore: true)
  int errorCode;

  String get name => '$firstName $lastName';

  Map<String, dynamic> toJson() => _$MemberToJson(this);
}
