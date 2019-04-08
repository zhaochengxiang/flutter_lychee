// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      json['id'] as int,
      json['sid'] as int,
      json['token'] as String,
      json['phone'] as String,
      json['username'] as String,
      json['createTime'] as int,
      json['avatar'] as String,
      json['sex'] as int,
      json['city'] as String,
      json['openBook'] as int,
      json['bookQuantity'] as int,
      json['libraryQuantity'] as int,
      json['clippingQuantity'] as int,
      json['friendQuantity'] as int,
      json['wantReadQuantity'] as int,
      json['haveReadQuantity'] as int,
      json['collectionQuantity'] as int,
      json['borrowedQuantity'] as int,
      json['borrowingQuantity'] as int,
      json['lentQuantity'] as int,
      json['lendingQuantity'] as int,
      json['unreadMessageQuantity'] as int);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'sid': instance.sid,
      'token': instance.token,
      'phone': instance.phone,
      'username': instance.username,
      'createTime': instance.createTime,
      'avatar': instance.avatar,
      'sex': instance.sex,
      'city': instance.city,
      'openBook': instance.openBook,
      'bookQuantity': instance.bookQuantity,
      'libraryQuantity': instance.libraryQuantity,
      'clippingQuantity': instance.clippingQuantity,
      'friendQuantity': instance.friendQuantity,
      'wantReadQuantity': instance.wantReadQuantity,
      'haveReadQuantity': instance.haveReadQuantity,
      'collectionQuantity': instance.collectionQuantity,
      'borrowedQuantity': instance.borrowedQuantity,
      'borrowingQuantity': instance.borrowingQuantity,
      'lentQuantity': instance.lentQuantity,
      'lendingQuantity': instance.lendingQuantity,
      'unreadMessageQuantity': instance.unreadMessageQuantity
    };
