// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Index.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Index _$IndexFromJson(Map<String, dynamic> json) {
  return Index(
      (json['bannerList'] as List)
          ?.map((e) =>
              e == null ? null : Banner.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['activityList'] as List)
          ?.map((e) =>
              e == null ? null : Activity.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['chosenBookList'] as List)
          ?.map((e) =>
              e == null ? null : Book.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['city'] as String)
    ..chosenLessonList = (json['chosenLessonList'] as List)
        ?.map((e) =>
            e == null ? null : Lesson.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..chosenCourseList = (json['chosenCourseList'] as List)
        ?.map((e) =>
            e == null ? null : Course.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$IndexToJson(Index instance) => <String, dynamic>{
      'bannerList': instance.bannerList,
      'activityList': instance.activityList,
      'chosenBookList': instance.chosenBookList,
      'chosenLessonList': instance.chosenLessonList,
      'chosenCourseList': instance.chosenCourseList,
      'city': instance.city
    };
