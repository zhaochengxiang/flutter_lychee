// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Frame.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Frame _$FrameFromJson(Map<String, dynamic> json) {
  return Frame(json['id'] as int, json['lid'] as int, json['uid'] as int,
      json['name'] as String);
}

Map<String, dynamic> _$FrameToJson(Frame instance) => <String, dynamic>{
      'id': instance.id,
      'lid': instance.lid,
      'uid': instance.uid,
      'name': instance.name
    };
