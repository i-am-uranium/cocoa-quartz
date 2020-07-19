import 'package:json_annotation/json_annotation.dart';
import 'invite.dart';

part 'invites.g.dart';

@JsonSerializable(nullable: false)
class Invites {
  Invites({this.totalCount, this.pageNumber, this.pageSize, this.invites});

  factory Invites.fromJson(Map<String, dynamic> json) =>
      _$InvitesFromJson(json);

  @JsonKey(name: 'total_count')
  final int totalCount;
  @JsonKey(name: 'page_number')
  final int pageNumber;
  @JsonKey(name: 'page_size')
  final int pageSize;
  final List<Invite> invites;

  Map<String, dynamic> toJson() => _$InvitesToJson(this);
}
