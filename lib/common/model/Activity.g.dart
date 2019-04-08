// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) {
  return Activity(
      json['id'] as int,
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
              e == null ? null : Speaker.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
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
