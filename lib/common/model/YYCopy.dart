import 'package:json_annotation/json_annotation.dart';

part 'YYCopy.g.dart';

@JsonSerializable()
class YYCopy {
  static int TYPE_ORGANIZE = 0;
  static int TYPE_PERSONAL= 1;
  static int STATE_OUT = 0;
  static int STATE_IN = 1;

  double id;
  double bid;
  double lid;
  double uid;
  double sid;
  double fid;
  int state;
  String serialNumber;
  String callNumber;
  String location;
  String username;
  String avatar;

  YYCopy(
    this.id,
    this.bid,
    this.lid,
    this.uid,
    this.sid,
    this.fid,
    this.state,
    this.serialNumber,
    this.callNumber,
    this.location,
    this.username,
    this.avatar
  );

  factory YYCopy.fromJson(Map<String, dynamic> json) => _$YYCopyFromJson(json);

  Map<String, dynamic> toJson() => _$YYCopyToJson(this);
}
