// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lesson _$LessonFromJson(Map<String, dynamic> json) {
  return Lesson(
      json['id'] as int,
      json['category'] as int,
      json['type'] as int,
      json['sid'] as int,
      json['cid'] as int,
      json['free'] as int,
      json['title'] as String,
      json['cover'] as String,
      json['markedPrice'] as int,
      json['salePrice'] as int,
      json['introduction'] as String,
      json['content'] as String,
      json['url'] as String,
      json['author'] as String,
      json['avatar'] as String,
      json['honor'] as String,
      json['resume'] as String,
      json['paid'] as bool,
      json['mime'] as int,
      json['favorite'] as bool,
      json['uuid'] as String);
}

Map<String, dynamic> _$LessonToJson(Lesson instance) => <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'type': instance.type,
      'sid': instance.sid,
      'cid': instance.cid,
      'free': instance.free,
      'title': instance.title,
      'cover': instance.cover,
      'markedPrice': instance.markedPrice,
      'salePrice': instance.salePrice,
      'introduction': instance.introduction,
      'content': instance.content,
      'url': instance.url,
      'author': instance.author,
      'avatar': instance.avatar,
      'honor': instance.honor,
      'resume': instance.resume,
      'paid': instance.paid,
      'mime': instance.mime,
      'favorite': instance.favorite,
      'uuid': instance.uuid
    };
