// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'YYBookHome.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YYBookHome _$YYBookHomeFromJson(Map<String, dynamic> json) {
  return YYBookHome(
      (json['fineList'] as List)
          ?.map((e) =>
              e == null ? null : YYBook.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['latestList'] as List)
          ?.map((e) =>
              e == null ? null : YYBook.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['topPopularList'] as List)
          ?.map((e) =>
              e == null ? null : YYBook.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$YYBookHomeToJson(YYBookHome instance) =>
    <String, dynamic>{
      'fineList': instance.fineList,
      'latestList': instance.latestList,
      'topPopularList': instance.topPopularList
    };
