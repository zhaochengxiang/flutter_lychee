// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Member _$MemberFromJson(Map<String, dynamic> json) {
  return Member(
      json['id'] as int,
      json['lid'] as int,
      json['uid'] as int,
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
          : BookResult.fromJson(json['sharingBooks'] as Map<String, dynamic>),
      json['borrowingBooks'] == null
          ? null
          : BookResult.fromJson(
              json['borrowingBooks'] as Map<String, dynamic>));
}

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
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
