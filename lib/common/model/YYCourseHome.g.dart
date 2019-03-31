// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'YYCourseHome.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YYCourseHome _$YYCourseHomeFromJson(Map<String, dynamic> json) {
  return YYCourseHome(
      (json['recommendList'] as List)
          ?.map((e) =>
              e == null ? null : YYCourse.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['fineList'] as List)
          ?.map((e) =>
              e == null ? null : YYCourse.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$YYCourseHomeToJson(YYCourseHome instance) =>
    <String, dynamic>{
      'recommendList': instance.recommendList,
      'fineList': instance.fineList
    };
