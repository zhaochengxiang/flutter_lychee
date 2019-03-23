// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'YYCourse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YYCourse _$YYCourseFromJson(Map<String, dynamic> json) {
  return YYCourse(
      (json['id'] as num)?.toDouble(),
      json['category'] as int,
      json['type'] as int,
      (json['sid'] as num)?.toDouble(),
      json['free'] as int,
      json['title'] as String,
      json['cover'] as String,
      json['markedPrice'] as int,
      json['salePrice'] as int,
      json['discount'] as int,
      json['introduction'] as String,
      json['author'] as String,
      json['avatar'] as String,
      json['honor'] as String,
      (json['lessonList'] as List)
          ?.map((e) =>
              e == null ? null : YYLesson.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['paid'] as bool,
      json['lessonQuantity'] as int,
      json['favorite'] as bool,
      json['uuid'] as String);
}

Map<String, dynamic> _$YYCourseToJson(YYCourse instance) => <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'type': instance.type,
      'sid': instance.sid,
      'free': instance.free,
      'title': instance.title,
      'cover': instance.cover,
      'markedPrice': instance.markedPrice,
      'salePrice': instance.salePrice,
      'discount': instance.discount,
      'introduction': instance.introduction,
      'author': instance.author,
      'avatar': instance.avatar,
      'honor': instance.honor,
      'lessonList': instance.lessonList,
      'paid': instance.paid,
      'lessonQuantity': instance.lessonQuantity,
      'favorite': instance.favorite,
      'uuid': instance.uuid
    };
