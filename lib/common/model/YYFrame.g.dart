// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'YYFrame.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YYFrame _$YYFrameFromJson(Map<String, dynamic> json) {
  return YYFrame(
      (json['id'] as num)?.toDouble(),
      (json['lid'] as num)?.toDouble(),
      (json['uid'] as num)?.toDouble(),
      json['name'] as String);
}

Map<String, dynamic> _$YYFrameToJson(YYFrame instance) => <String, dynamic>{
      'id': instance.id,
      'lid': instance.lid,
      'uid': instance.uid,
      'name': instance.name
    };
