import 'package:json_annotation/json_annotation.dart';

part 'generic_response.g.dart';

@JsonSerializable(nullable: false)
class GenericResponse {
  GenericResponse({
    this.success,
    this.error,
    this.errorCode,
    this.result,
  });
  factory GenericResponse.fromJson(Map<String, dynamic> json) =>
      _$GenericResponseFromJson(json);

  bool success;
  String error;
  int errorCode;
  dynamic result;

  Map<String, dynamic> toJson() => _$GenericResponseToJson(this);
}
