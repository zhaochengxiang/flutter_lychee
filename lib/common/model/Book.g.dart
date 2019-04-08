// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) {
  return Book(
      json['id'] as int,
      json['oid'] as int,
      json['uuid'] as String,
      json['isbn'] as String,
      json['title'] as String,
      json['author'] as String,
      json['date'] as String,
      json['cover'] as String,
      json['category'] as String,
      json['summary'] as String,
      json['press'] as String,
      json['wantReadQuantity'] as int,
      json['haveReadQuantity'] as int,
      json['collectionQuantity'] as int,
      json['noteQuantity'] as int,
      json['error'] as String,
      json['selected'] as bool);
}

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'id': instance.id,
      'oid': instance.oid,
      'uuid': instance.uuid,
      'isbn': instance.isbn,
      'title': instance.title,
      'author': instance.author,
      'date': instance.date,
      'cover': instance.cover,
      'category': instance.category,
      'summary': instance.summary,
      'press': instance.press,
      'wantReadQuantity': instance.wantReadQuantity,
      'haveReadQuantity': instance.haveReadQuantity,
      'collectionQuantity': instance.collectionQuantity,
      'noteQuantity': instance.noteQuantity,
      'error': instance.error,
      'selected': instance.selected
    };
