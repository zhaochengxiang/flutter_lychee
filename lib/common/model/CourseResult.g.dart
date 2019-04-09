// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CourseResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseResult _$CourseResultFromJson(Map<String, dynamic> json) {
  return CourseResult(
      json['total'] as int,
      json['last'] as int,
      json['offset'] as int,
      json['hasNext'] as bool,
      (json['list'] as List)
          ?.map((e) =>
              e == null ? null : Course.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$CourseResultToJson(CourseResult instance) =>
    <String, dynamic>{
      'total': instance.total,
      'last': instance.last,
      'offset': instance.offset,
      'hasNext': instance.hasNext,
      'list': instance.list
    };
