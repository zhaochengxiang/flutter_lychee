import 'package:json_annotation/json_annotation.dart';

part 'YYSpeaker.g.dart';

@JsonSerializable()
class YYSpeaker {
  double id;
  /**
   * activity id
   */
  double aid;
  /**
   * scholar id
   */
  double sid;
  double uid;
  /**
   * 姓名
   */
  String username;
  /**
   * 简历
   */
  String resume;

  YYSpeaker(
    this.id,
    this.aid,
    this.sid,
    this.uid,
    this.username,
    this.resume,
  );

  factory YYSpeaker.fromJson(Map<String, dynamic> json) => _$YYSpeakerFromJson(json);

  Map<String, dynamic> toJson() => _$YYSpeakerToJson(this);
}
