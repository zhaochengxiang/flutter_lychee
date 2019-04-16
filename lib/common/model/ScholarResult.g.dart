// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ScholarResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScholarResult _$ScholarResultFromJson(Map<String, dynamic> json) {
  return ScholarResult(
      json['total'] as int,
      json['last'] as int,
      json['offset'] as int,
      json['hasNext'] as bool,
      (json['list'] as List)
          ?.map((e) =>
              e == null ? null : Scholar.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$ScholarResultToJson(ScholarResult instance) =>
    <String, dynamic>{
      'total': instance.total,
      'last': instance.last,
      'offset': instance.offset,
      'hasNext': instance.hasNext,
      'list': instance.list
    };
