// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'YYLessonHome.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YYLessonHome _$YYLessonHomeFromJson(Map<String, dynamic> json) {
  return YYLessonHome(
      (json['recommendList'] as List)
          ?.map((e) =>
              e == null ? null : YYLesson.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['fineList'] as List)
          ?.map((e) =>
              e == null ? null : YYLesson.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$YYLessonHomeToJson(YYLessonHome instance) =>
    <String, dynamic>{
      'recommendList': instance.recommendList,
      'fineList': instance.fineList
    };
