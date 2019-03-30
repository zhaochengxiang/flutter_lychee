// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'YYMember.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YYMember _$YYMemberFromJson(Map<String, dynamic> json) {
  return YYMember(
      (json['id'] as num)?.toDouble(),
      (json['lid'] as num)?.toDouble(),
      (json['uid'] as num)?.toDouble(),
      json['state'] as int,
      json['role'] as int,
      json['department'] as String,
      json['username'] as String,
      json['borrowedQuantity'] as int,
      json['borrowingQuantity'] as int,
      json['avatar'] as String,
      json['revisable'] as bool,
      json['sharingBooks'] == null
          ? null
          : YYBookResult.fromJson(json['sharingBooks'] as Map<String, dynamic>),
      json['borrowingBooks'] == null
          ? null
          : YYBookResult.fromJson(
              json['borrowingBooks'] as Map<String, dynamic>));
}

Map<String, dynamic> _$YYMemberToJson(YYMember instance) => <String, dynamic>{
      'id': instance.id,
      'lid': instance.lid,
      'uid': instance.uid,
      'state': instance.state,
      'role': instance.role,
      'department': instance.department,
      'username': instance.username,
      'borrowedQuantity': instance.borrowedQuantity,
      'borrowingQuantity': instance.borrowingQuantity,
      'avatar': instance.avatar,
      'revisable': instance.revisable,
      'sharingBooks': instance.sharingBooks,
      'borrowingBooks': instance.borrowingBooks
    };
