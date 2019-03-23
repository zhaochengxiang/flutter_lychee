// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'YYLesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YYLesson _$YYLessonFromJson(Map<String, dynamic> json) {
  return YYLesson(
      (json['id'] as num)?.toDouble(),
      json['category'] as int,
      json['type'] as int,
      (json['sid'] as num)?.toDouble(),
      (json['cid'] as num)?.toDouble(),
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
      json['paid'] as bool);
}

Map<String, dynamic> _$YYLessonToJson(YYLesson instance) => <String, dynamic>{
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
      'paid': instance.paid
    };
