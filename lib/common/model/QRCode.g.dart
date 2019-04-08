// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QRCode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QRCode _$QRCodeFromJson(Map<String, dynamic> json) {
  return QRCode(json['type'] as int, json['lid'] as int,
      (json['list'] as List)?.map((e) => e as int)?.toList());
}

Map<String, dynamic> _$QRCodeToJson(QRCode instance) => <String, dynamic>{
      'type': instance.type,
      'lid': instance.lid,
      'list': instance.list
    };
