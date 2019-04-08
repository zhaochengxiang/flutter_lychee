// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Copy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Copy _$CopyFromJson(Map<String, dynamic> json) {
  return Copy(
      json['id'] as int,
      json['bid'] as int,
      json['lid'] as int,
      json['uid'] as int,
      json['sid'] as int,
      json['fid'] as int,
      json['state'] as int,
      json['serialNumber'] as String,
      json['callNumber'] as String,
      json['location'] as String,
      json['username'] as String,
      json['avatar'] as String);
}

Map<String, dynamic> _$CopyToJson(Copy instance) => <String, dynamic>{
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
