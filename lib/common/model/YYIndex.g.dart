// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'YYIndex.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YYIndex _$YYIndexFromJson(Map<String, dynamic> json) {
  return YYIndex(
      (json['bannerList'] as List)
          ?.map((e) =>
              e == null ? null : YYBanner.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['activityList'] as List)
          ?.map((e) =>
              e == null ? null : YYActivity.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['chosenBookList'] as List)
          ?.map((e) =>
              e == null ? null : YYBook.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['city'] as String)
    ..chosenLessonList = (json['chosenLessonList'] as List)
        ?.map((e) =>
            e == null ? null : YYLesson.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..chosenCourseList = (json['chosenCourseList'] as List)
        ?.map((e) =>
            e == null ? null : YYCourse.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$YYIndexToJson(YYIndex instance) => <String, dynamic>{
      'bannerList': instance.bannerList,
      'activityList': instance.activityList,
      'chosenBookList': instance.chosenBookList,
      'chosenLessonList': instance.chosenLessonList,
      'chosenCourseList': instance.chosenCourseList,
      'city': instance.city
    };
