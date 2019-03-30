// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'YYReceipt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YYReceipt _$YYReceiptFromJson(Map<String, dynamic> json) {
  return YYReceipt(
      (json['id'] as num)?.toDouble(),
      (json['lid'] as num)?.toDouble(),
      (json['bid'] as num)?.toDouble(),
      (json['cid'] as num)?.toDouble(),
      (json['lender'] as num)?.toDouble(),
      (json['borrower'] as num)?.toDouble(),
      json['state'] as int,
      json['borrowDate'] as int,
      json['returnDate'] as int,
      json['title'] as String,
      json['author'] as String,
      json['date'] as String,
      json['press'] as String,
      json['cover'] as String,
      json['wantReadQuantity'] as int,
      json['haveReadQuantity'] as int,
      json['collectionQuantity'] as int,
      json['noteQuantity'] as int,
      json['selected'] as bool,
      json['error'] as String);
}

Map<String, dynamic> _$YYReceiptToJson(YYReceipt instance) => <String, dynamic>{
      'id': instance.id,
      'lid': instance.lid,
      'bid': instance.bid,
      'cid': instance.cid,
      'lender': instance.lender,
      'borrower': instance.borrower,
      'state': instance.state,
      'borrowDate': instance.borrowDate,
      'returnDate': instance.returnDate,
      'title': instance.title,
      'author': instance.author,
      'date': instance.date,
      'press': instance.press,
      'cover': instance.cover,
      'wantReadQuantity': instance.wantReadQuantity,
      'haveReadQuantity': instance.haveReadQuantity,
      'collectionQuantity': instance.collectionQuantity,
      'noteQuantity': instance.noteQuantity,
      'selected': instance.selected,
      'error': instance.error
    };
