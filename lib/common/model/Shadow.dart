import 'package:json_annotation/json_annotation.dart';

part 'Shadow.g.dart';

@JsonSerializable()
class Shadow {
  String id;
  int type;

  Shadow(
    this.id,
    this.type
  );

  factory Shadow.fromJson(Map<String, dynamic> json) => _$ShadowFromJson(json);

  Map<String, dynamic> toJson() => _$ShadowToJson(this);
}
