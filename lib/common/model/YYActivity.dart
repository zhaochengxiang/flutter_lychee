import 'package:json_annotation/json_annotation.dart';
import 'package:lychee/common/model/YYSpeaker.dart';

part 'YYActivity.g.dart';

@JsonSerializable()
class YYActivity {
    double id;
    String type;
    String subject;
    String detail;
    String sponsor;
    String city;
    String address;
    String time;
    String registration;
    String link;
    List<YYSpeaker> speakerList;

  YYActivity(
    this.id,
    this.type,
    this.subject,
    this.detail,
    this.sponsor,
    this.city,
    this.address,
    this.time,
    this.registration,
    this.link,
    this.speakerList
  );

  factory YYActivity.fromJson(Map<String, dynamic> json) => _$YYActivityFromJson(json);

  Map<String, dynamic> toJson() => _$YYActivityToJson(this);
}
