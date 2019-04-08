// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RichBook.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RichBook _$RichBookFromJson(Map<String, dynamic> json) {
  return RichBook(
      json['book'] == null
          ? null
          : Book.fromJson(json['book'] as Map<String, dynamic>),
      json['wantRead'] as bool,
      (json['favoriteList'] as List)
          ?.map((e) =>
              e == null ? null : Book.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['libraryList'] as List)
          ?.map((e) =>
              e == null ? null : Library.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['copyList'] as List)
          ?.map((e) =>
              e == null ? null : Copy.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['scholarList'] as List)
          ?.map((e) =>
              e == null ? null : Scholar.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$RichBookToJson(RichBook instance) => <String, dynamic>{
      'book': instance.book,
      'wantRead': instance.wantRead,
      'favoriteList': instance.favoriteList,
      'libraryList': instance.libraryList,
      'copyList': instance.copyList,
      'scholarList': instance.scholarList
    };
