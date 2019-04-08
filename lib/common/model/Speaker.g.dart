// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Speaker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Speaker _$SpeakerFromJson(Map<String, dynamic> json) {
  return Speaker(json['id'] as int, json['aid'] as int, json['sid'] as int,
      json['uid'] as int, json['username'] as String, json['resume'] as String);
}

Map<String, dynamic> _$SpeakerToJson(Speaker instance) => <String, dynamic>{
      'id': instance.id,
      'aid': instance.aid,
      'sid': instance.sid,
      'uid': instance.uid,
      'username': instance.username,
      'resume': instance.resume
    };
