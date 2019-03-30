import 'package:json_annotation/json_annotation.dart';

part 'YYReceipt.g.dart';

@JsonSerializable()
class YYReceipt {
  static int STATE_ORDER = 0;
  static int STATE_LENT = 1;
  double id;
  double lid;
  double bid;
  double cid;
  double lender;
  double borrower;
  int state;
  int borrowDate;
  int returnDate;
  String title;
  String author;
  String date;
  String press;
  String cover;
  int wantReadQuantity;
  int haveReadQuantity;
  int collectionQuantity;
  int noteQuantity;
  bool selected;
  String  error;

  YYReceipt(
    this.id,
    this.lid,
    this.bid,
    this.cid,
    this.lender,
    this.borrower,
    this.state,
    this.borrowDate,
    this.returnDate,
    this.title,
    this.author,
    this.date,
    this.press,
    this.cover,
    this.wantReadQuantity,
    this.haveReadQuantity,
    this.collectionQuantity,
    this.noteQuantity,
    this.selected,
    this.error,
  );

  factory YYReceipt.fromJson(Map<String, dynamic> json) => _$YYReceiptFromJson(json);

  Map<String, dynamic> toJson() => _$YYReceiptToJson(this);
}
