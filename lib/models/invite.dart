import 'package:json_annotation/json_annotation.dart';
import 'member.dart';

part 'invite.g.dart';

@JsonSerializable(nullable: false)
class Invite {
  Invite(
      {this.id,
      this.categories,
      this.date,
      this.status,
      this.sender,
      this.receiver});

  factory Invite.fromJson(Map<String, dynamic> json) => _$InviteFromJson(json);

  final String id;
  final List<String> categories;
  final int date;
  final String status;
  final Member sender;
  final Member receiver;

  Map<String, dynamic> toJson() => _$InviteToJson(this);
}
