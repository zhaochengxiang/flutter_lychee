// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ReceiptResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptResult _$ReceiptResultFromJson(Map<String, dynamic> json) {
  return ReceiptResult(
      json['uid'] as int,
      json['lid'] as int,
      json['name'] as String,
      (json['receiptList'] as List)
          ?.map((e) =>
              e == null ? null : Receipt.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['selected'] as bool,
      json['locked'] as bool,
      json['personal'] as bool);
}

Map<String, dynamic> _$ReceiptResultToJson(ReceiptResult instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'lid': instance.lid,
      'name': instance.name,
      'receiptList': instance.receiptList,
      'selected': instance.selected,
      'locked': instance.locked,
      'personal': instance.personal
    };
