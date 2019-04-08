// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Scholar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Scholar _$ScholarFromJson(Map<String, dynamic> json) {
  return Scholar(
      json['id'] as int,
      json['type'] as int,
      json['name'] as String,
      json['verified'] as int,
      json['avatar'] as String,
      json['honor'] as String,
      json['resume'] as String,
      json['followed'] as bool,
      (json['courseList'] as List)
          ?.map((e) =>
              e == null ? null : Course.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['lessonList'] as List)
          ?.map((e) =>
              e == null ? null : Lesson.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['bookList'] as List)
          ?.map((e) =>
              e == null ? null : Book.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$ScholarToJson(Scholar instance) => <String, dynamic>{
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
