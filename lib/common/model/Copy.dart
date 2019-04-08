import 'package:json_annotation/json_annotation.dart';

part 'Copy.g.dart';

@JsonSerializable()
class Copy {
  static int TYPE_ORGANIZE = 0;
  static int TYPE_PERSONAL= 1;
  static int STATE_OUT = 0;
  static int STATE_IN = 1;

  int id;
  int bid;
  int lid;
  int uid;
  int sid;
  int fid;
  int state;
  String serialNumber;
  String callNumber;
  String location;
  String username;
  String avatar;

  Copy(
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

  factory Copy.fromJson(Map<String, dynamic> json) => _$CopyFromJson(json);

  Map<String, dynamic> toJson() => _$CopyToJson(this);
}
