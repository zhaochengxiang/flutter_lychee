// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'YYCategory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YYCategory _$YYCategoryFromJson(Map<String, dynamic> json) {
  return YYCategory(
      json['id'] as int,
      json['name'] as String,
      (json['children'] as List)
          ?.map((e) =>
              e == null ? null : YYCategory.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$YYCategoryToJson(YYCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'children': instance.children
    };
