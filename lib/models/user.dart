import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(nullable: false)
class User {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.gender,
    this.phone,
    this.status,
    this.error,
    this.errorCode,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final int id;
  @JsonKey(name: 'first_name')
  final String firstName;

  @JsonKey(name: 'last_name')
  final String lastName;

  final String gender;
  @JsonKey(name: 'primary_number')
  final String phone;

  final String status;

  @JsonKey(ignore: true)
  String error;
  @JsonKey(ignore: true)
  int errorCode;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
