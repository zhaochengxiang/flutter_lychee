// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'YYScholar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YYScholar _$YYScholarFromJson(Map<String, dynamic> json) {
  return YYScholar(
      (json['id'] as num)?.toDouble(),
      json['type'] as int,
      json['name'] as String,
      json['verified'] as int,
      json['avatar'] as String,
      json['honor'] as String,
      json['resume'] as String,
      json['followed'] as bool,
      (json['courseList'] as List)
          ?.map((e) =>
              e == null ? null : YYCourse.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['lessonList'] as List)
          ?.map((e) =>
              e == null ? null : YYLesson.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['bookList'] as List)
          ?.map((e) =>
              e == null ? null : YYBook.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$YYScholarToJson(YYScholar instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'verified': instance.verified,
      'avatar': instance.avatar,
      'honor': instance.honor,
      'resume': instance.resume,
      'followed': instance.followed,
      'courseList': instance.courseList,
      'lessonList': instance.lessonList,
      'bookList': instance.bookList
    };
