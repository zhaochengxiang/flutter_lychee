import 'package:json_annotation/json_annotation.dart';

part 'QRCode.g.dart';

@JsonSerializable()

class QRCode {
  static int TYPE_APPLY_JOIN = 0;
  static int TYPE_INVITE_JOIN = 1;
  static int TYPE_BORROW_FROM_PERSON = 2;
  static int TYPE_RETURN_TO_PERSON = 3;
  static int TYPE_BORROW_FROM_ORGANIZE = 4;
  static int TYPE_RETURN_TO_ORGANIZE = 5;
  int type;
  int lid;
  List<int> list;

  QRCode(
    this.type,
    this.lid,
    this.list
  );

  factory QRCode.fromJson(Map<String, dynamic> json) => _$QRCodeFromJson(json);

  Map<String, dynamic> toJson() => _$QRCodeToJson(this);
}
