// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LessonResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonResult _$LessonResultFromJson(Map<String, dynamic> json) {
  return LessonResult(
      json['total'] as int,
      json['last'] as int,
      json['offset'] as int,
      json['hasNext'] as bool,
      (json['list'] as List)
          ?.map((e) =>
              e == null ? null : Lesson.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$LessonResultToJson(LessonResult instance) =>
    <String, dynamic>{
      'total': instance.total,
      'last': instance.last,
      'offset': instance.offset,
      'hasNext': instance.hasNext,
      'list': instance.list
    };
