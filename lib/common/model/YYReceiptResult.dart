import 'package:json_annotation/json_annotation.dart';
import 'package:lychee/common/model/YYReceipt.dart';

part 'YYReceiptResult.g.dart';

@JsonSerializable()
class YYReceiptResult {
  double uid;
  double lid;
  String name;
  List<YYReceipt> receiptList;
  bool selected;
  bool locked;
  bool personal;

  YYReceiptResult(
    this.uid,
    this.lid,
    this.name,
    this.receiptList,
    this.selected,
    this.locked,
    this.personal,
  );

  factory YYReceiptResult.fromJson(Map<String, dynamic> json) => _$YYReceiptResultFromJson(json);

  Map<String, dynamic> toJson() => _$YYReceiptResultToJson(this);
}
