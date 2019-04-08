// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BookResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookResult _$BookResultFromJson(Map<String, dynamic> json) {
  return BookResult(
      json['total'] as int,
      json['last'] as int,
      json['offset'] as int,
      json['hasNext'] as bool,
      (json['list'] as List)
          ?.map((e) =>
              e == null ? null : Book.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$BookResultToJson(BookResult instance) =>
    <String, dynamic>{
      'total': instance.total,
      'last': instance.last,
      'offset': instance.offset,
      'hasNext': instance.hasNext,
      'list': instance.list
    };
