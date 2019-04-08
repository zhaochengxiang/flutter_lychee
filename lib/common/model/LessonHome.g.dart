// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LessonHome.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonHome _$LessonHomeFromJson(Map<String, dynamic> json) {
  return LessonHome(
      (json['recommendList'] as List)
          ?.map((e) =>
              e == null ? null : Lesson.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['fineList'] as List)
          ?.map((e) =>
              e == null ? null : Lesson.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$LessonHomeToJson(LessonHome instance) =>
    <String, dynamic>{
      'recommendList': instance.recommendList,
      'fineList': instance.fineList
    };
