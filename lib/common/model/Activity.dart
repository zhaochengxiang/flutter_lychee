import 'package:json_annotation/json_annotation.dart';
import 'package:lychee/common/model/Speaker.dart';

part 'Activity.g.dart';

@JsonSerializable()
class Activity {
    int id;
    String type;
    String subject;
    String detail;
    String sponsor;
    String city;
    String address;
    String time;
    String registration;
    String link;
    List<Speaker> speakerList;

  Activity(
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

  factory Activity.fromJson(Map<String, dynamic> json) => _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}
