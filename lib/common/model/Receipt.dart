import 'package:json_annotation/json_annotation.dart';

part 'Receipt.g.dart';

@JsonSerializable()
class Receipt {
  static int STATE_ORDER = 0;
  static int STATE_LENT = 1;
  int id;
  int lid;
  int bid;
  int cid;
  int lender;
  int borrower;
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

  Receipt(
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

  factory Receipt.fromJson(Map<String, dynamic> json) => _$ReceiptFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiptToJson(this);
}
