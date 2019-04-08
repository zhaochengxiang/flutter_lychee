import 'package:json_annotation/json_annotation.dart';
import 'package:lychee/common/model/Receipt.dart';

part 'ReceiptResult.g.dart';

@JsonSerializable()
class ReceiptResult {
  int uid;
  int lid;
  String name;
  List<Receipt> receiptList;
  bool selected;
  bool locked;
  bool personal;

  ReceiptResult(
    this.uid,
    this.lid,
    this.name,
    this.receiptList,
    this.selected,
    this.locked,
    this.personal,
  );

  factory ReceiptResult.fromJson(Map<String, dynamic> json) => _$ReceiptResultFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiptResultToJson(this);
}
