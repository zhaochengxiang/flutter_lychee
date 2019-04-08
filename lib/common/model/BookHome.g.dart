// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BookHome.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookHome _$BookHomeFromJson(Map<String, dynamic> json) {
  return BookHome(
      (json['fineList'] as List)
          ?.map((e) =>
              e == null ? null : Book.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['latestList'] as List)
          ?.map((e) =>
              e == null ? null : Book.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['topPopularList'] as List)
          ?.map((e) =>
              e == null ? null : Book.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$BookHomeToJson(BookHome instance) => <String, dynamic>{
      'fineList': instance.fineList,
      'latestList': instance.latestList,
      'topPopularList': instance.topPopularList
    };
