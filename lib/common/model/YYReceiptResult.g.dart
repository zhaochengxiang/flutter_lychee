// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'YYReceiptResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YYReceiptResult _$YYReceiptResultFromJson(Map<String, dynamic> json) {
  return YYReceiptResult(
      (json['uid'] as num)?.toDouble(),
      (json['lid'] as num)?.toDouble(),
      json['name'] as String,
      (json['receiptList'] as List)
          ?.map((e) =>
              e == null ? null : YYReceipt.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['selected'] as bool,
      json['locked'] as bool,
      json['personal'] as bool);
}

Map<String, dynamic> _$YYReceiptResultToJson(YYReceiptResult instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'lid': instance.lid,
      'name': instance.name,
      'receiptList': instance.receiptList,
      'selected': instance.selected,
      'locked': instance.locked,
      'personal': instance.personal
    };
