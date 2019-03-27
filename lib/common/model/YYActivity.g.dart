// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'YYActivity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YYActivity _$YYActivityFromJson(Map<String, dynamic> json) {
  return YYActivity(
      (json['id'] as num)?.toDouble(),
      json['type'] as String,
      json['subject'] as String,
      json['detail'] as String,
      json['sponsor'] as String,
      json['city'] as String,
      json['address'] as String,
      json['time'] as String,
      json['registration'] as String,
      json['link'] as String,
      (json['speakerList'] as List)
          ?.map((e) =>
              e == null ? null : YYSpeaker.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$YYActivityToJson(YYActivity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'subject': instance.subject,
      'detail': instance.detail,
      'sponsor': instance.sponsor,
      'city': instance.city,
      'address': instance.address,
      'time': instance.time,
      'registration': instance.registration,
      'link': instance.link,
      'speakerList': instance.speakerList
    };
