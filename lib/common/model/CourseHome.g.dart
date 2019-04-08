// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CourseHome.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseHome _$CourseHomeFromJson(Map<String, dynamic> json) {
  return CourseHome(
      (json['recommendList'] as List)
          ?.map((e) =>
              e == null ? null : Course.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['fineList'] as List)
          ?.map((e) =>
              e == null ? null : Course.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$CourseHomeToJson(CourseHome instance) =>
    <String, dynamic>{
      'recommendList': instance.recommendList,
      'fineList': instance.fineList
    };
