// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Library.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Library _$LibraryFromJson(Map<String, dynamic> json) {
  return Library(
      json['id'] as int,
      json['name'] as String,
      json['type'] as int,
      json['state'] as int,
      json['openJoin'] as int,
      json['openApply'] as int,
      json['enableInvite'] as int,
      json['openSearch'] as int,
      json['openQuit'] as int,
      json['openShare'] as int,
      json['openProfile'] as int,
      json['enableIndex'] as int,
      json['enableDismiss'] as int,
      json['professional'] as int,
      json['address'] as String,
      json['phone'] as String,
      json['province'] as String,
      json['city'] as String,
      json['cityCode'] as String,
      json['addressCode'] as String,
      json['district'] as String,
      json['distance'] as int,
      (json['intitude'] as num)?.toDouble(),
      (json['latitude'] as num)?.toDouble(),
      (json['receiptList'] as List)
          ?.map((e) =>
              e == null ? null : Receipt.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['copyList'] as List)
          ?.map((e) =>
              e == null ? null : Copy.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['myself'] == null
          ? null
          : Member.fromJson(json['myself'] as Map<String, dynamic>),
      json['bookQuantity'] as int,
      json['memberQuantity'] as int,
      json['readingQuantity'] as int,
      json['borrowedQuantity'] as int,
      json['borrowingQuantity'] as int,
      json['announcement'] as String,
      json['borrowQuantity'] as int,
      json['borrowDay'] as int,
      json['located'] as bool,
      json['expanded'] as bool);
}

Map<String, dynamic> _$LibraryToJson(Library instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'state': instance.state,
      'openJoin': instance.openJoin,
      'openApply': instance.openApply,
      'enableInvite': instance.enableInvite,
      'openSearch': instance.openSearch,
      'openQuit': instance.openQuit,
      'openShare': instance.openShare,
      'openProfile': instance.openProfile,
      'enableIndex': instance.enableIndex,
      'enableDismiss': instance.enableDismiss,
      'professional': instance.professional,
      'address': instance.address,
      'phone': instance.phone,
      'province': instance.province,
      'city': instance.city,
      'cityCode': instance.cityCode,
      'addressCode': instance.addressCode,
      'district': instance.district,
      'distance': instance.distance,
      'intitude': instance.intitude,
      'latitude': instance.latitude,
      'receiptList': instance.receiptList,
      'copyList': instance.copyList,
      'myself': instance.myself,
      'bookQuantity': instance.bookQuantity,
      'memberQuantity': instance.memberQuantity,
      'readingQuantity': instance.readingQuantity,
      'borrowedQuantity': instance.borrowedQuantity,
      'borrowingQuantity': instance.borrowingQuantity,
      'announcement': instance.announcement,
      'borrowQuantity': instance.borrowQuantity,
      'borrowDay': instance.borrowDay,
      'located': instance.located,
      'expanded': instance.expanded
    };
