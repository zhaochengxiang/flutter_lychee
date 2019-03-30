// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'YYCopy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YYCopy _$YYCopyFromJson(Map<String, dynamic> json) {
  return YYCopy(
      (json['id'] as num)?.toDouble(),
      (json['bid'] as num)?.toDouble(),
      (json['lid'] as num)?.toDouble(),
      (json['uid'] as num)?.toDouble(),
      (json['sid'] as num)?.toDouble(),
      (json['fid'] as num)?.toDouble(),
      json['state'] as int,
      json['serialNumber'] as String,
      json['callNumber'] as String,
      json['location'] as String,
      json['username'] as String,
      json['avatar'] as String);
}

Map<String, dynamic> _$YYCopyToJson(YYCopy instance) => <String, dynamic>{
      'id': instance.id,
      'bid': instance.bid,
      'lid': instance.lid,
      'uid': instance.uid,
      'sid': instance.sid,
      'fid': instance.fid,
      'state': instance.state,
      'serialNumber': instance.serialNumber,
      'callNumber': instance.callNumber,
      'location': instance.location,
      'username': instance.username,
      'avatar': instance.avatar
    };
