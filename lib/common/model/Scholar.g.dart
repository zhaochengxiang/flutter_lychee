// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Scholar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Scholar _$ScholarFromJson(Map<String, dynamic> json) {
  return Scholar(
      id: json['id'] as int,
      type: json['type'] as int,
      name: json['name'] as String,
      verified: json['verified'] as int,
      avatar: json['avatar'] as String,
      honor: json['honor'] as String,
      resume: json['resume'] as String,
      followed: json['followed'] as bool,
      courseList: (json['courseList'] as List)
          ?.map((e) =>
              e == null ? null : Course.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      lessonList: (json['lessonList'] as List)
          ?.map((e) =>
              e == null ? null : Lesson.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      bookList: (json['bookList'] as List)
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
