// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'YYSpeaker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YYSpeaker _$YYSpeakerFromJson(Map<String, dynamic> json) {
  return YYSpeaker(
      (json['id'] as num)?.toDouble(),
      (json['aid'] as num)?.toDouble(),
      (json['sid'] as num)?.toDouble(),
      (json['uid'] as num)?.toDouble(),
      json['username'] as String,
      json['resume'] as String);
}

Map<String, dynamic> _$YYSpeakerToJson(YYSpeaker instance) => <String, dynamic>{
      'id': instance.id,
      'aid': instance.aid,
      'sid': instance.sid,
      'uid': instance.uid,
      'username': instance.username,
      'resume': instance.resume
    };
