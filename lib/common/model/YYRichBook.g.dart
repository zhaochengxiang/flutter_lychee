// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'YYRichBook.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YYRichBook _$YYRichBookFromJson(Map<String, dynamic> json) {
  return YYRichBook(
      json['book'] == null
          ? null
          : YYBook.fromJson(json['book'] as Map<String, dynamic>),
      json['wantRead'] as bool,
      (json['favoriteList'] as List)
          ?.map((e) =>
              e == null ? null : YYBook.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['libraryList'] as List)
          ?.map((e) =>
              e == null ? null : YYLibrary.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['copyList'] as List)
          ?.map((e) =>
              e == null ? null : YYCopy.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['scholarList'] as List)
          ?.map((e) =>
              e == null ? null : YYScholar.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$YYRichBookToJson(YYRichBook instance) =>
    <String, dynamic>{
      'book': instance.book,
      'wantRead': instance.wantRead,
      'favoriteList': instance.favoriteList,
      'libraryList': instance.libraryList,
      'copyList': instance.copyList,
      'scholarList': instance.scholarList
    };
