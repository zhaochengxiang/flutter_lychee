import 'package:json_annotation/json_annotation.dart';

part 'Speaker.g.dart';

@JsonSerializable()
class Speaker {
  int id;
  /**
   * activity id
   */
  int aid;
  /**
   * scholar id
   */
  int sid;
  int uid;
  /**
   * 姓名
   */
  String username;
  /**
   * 简历
   */
  String resume;

  Speaker(
    this.id,
    this.aid,
    this.sid,
    this.uid,
    this.username,
    this.resume,
  );

  factory Speaker.fromJson(Map<String, dynamic> json) => _$SpeakerFromJson(json);

  Map<String, dynamic> toJson() => _$SpeakerToJson(this);
}
