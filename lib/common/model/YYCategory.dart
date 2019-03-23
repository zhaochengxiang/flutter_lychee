import 'package:json_annotation/json_annotation.dart';

part 'YYCategory.g.dart';

@JsonSerializable()
class YYCategory {
  int id;
  String name;

  List<YYCategory> children;

   YYCategory(
    this.id,
    this.name,
    this.children,
  );

  factory YYCategory.fromJson(Map<String, dynamic> json) => _$YYCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$YYCategoryToJson(this);
}
