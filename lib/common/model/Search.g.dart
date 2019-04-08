// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Search _$SearchFromJson(Map<String, dynamic> json) {
  return Search(json['type'] as int, json['keyword'] as String,
      json['createDate'] as int);
}

Map<String, dynamic> _$SearchToJson(Search instance) => <String, dynamic>{
      'type': instance.type,
      'keyword': instance.keyword,
      'createDate': instance.createDate
    };
