// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'YYBookResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YYBookResult _$YYBookResultFromJson(Map<String, dynamic> json) {
  return YYBookResult(
      json['total'] as int,
      (json['last'] as num)?.toDouble(),
      json['offset'] as int,
      json['hasNext'] as bool,
      (json['list'] as List)
          ?.map((e) =>
              e == null ? null : YYBook.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$YYBookResultToJson(YYBookResult instance) =>
    <String, dynamic>{
      'total': instance.total,
      'last': instance.last,
      'offset': instance.offset,
      'hasNext': instance.hasNext,
      'list': instance.list
    };
