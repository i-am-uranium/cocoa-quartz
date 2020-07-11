import 'package:json_annotation/json_annotation.dart';

part 'prod.g.dart';

@JsonLiteral('prod.json', asConst: true)
Map<String, dynamic> get prodConfig => _$prodConfigJsonLiteral;
