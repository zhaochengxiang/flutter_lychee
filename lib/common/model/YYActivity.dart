import 'package:json_annotation/json_annotation.dart';
import 'package:lychee/common/model/YYSpeaker.dart';

part 'YYActivity.g.dart';

@JsonSerializable()
class YYActivity {
    double id;
    String type;
    /**
     * 主题
     */
    String subject;
    /**
     * 详情
     */
    String detail;
    /**
     * 主办方
     */
    String sponsor;
    /**
     * 城市
     */
    String city;
    /**
     * 地点
     */
    String address;
    /**
     * 时间
     */
    String time;
    /**
     * 报名方法或者方式
     */
    String registration;
    /**
     * 来源链接
     */
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
