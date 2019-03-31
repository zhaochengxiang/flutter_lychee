import 'package:json_annotation/json_annotation.dart';

part 'YYLesson.g.dart';

@JsonSerializable()
class YYLesson {
  double id;
  /**
   * 分类id
   */
  int category;
  /**
   * 类型，0 图文，1 语音，2 视频
   */
  int type;
  /**
   * 开设课程的Scholar id
   */
  double sid;
  /**
   * course id，所属课程ID，如果不属于任何课程，cid为0.
   */
  double cid;
  /**
   * 是否免费，0收费，1免费
   */
  int free;
  String title;
  /**
   * 封面
   */
  String cover;
  /**
   * 标价
   */
  int markedPrice;
  /**
   * 销售价格,0表示免费，-1表示不单独销售
   */
  int salePrice;
  /**
   * 课程简介
   */
  String introduction;
  /**
   * 图文内容
   */
  String content;
  /**
   * 语音和视频的播放url
   */
  String url;
  /**
   * 发布人名称
   */
  String author;
  /**
   * 发布人头像
   */
  String avatar;
  /**
   * 发布人荣誉
   */
  String honor;
  String resume;
  bool paid;
  int mime; 
  bool favorite;
  String uuid;

  YYLesson(
    this.id,
    this.category,
    this.type,
    this.sid,
    this.cid,
    this.free,
    this.title,
    this.cover,
    this.markedPrice,
    this.salePrice,
    this.introduction,
    this.content,
    this.url,
    this.author,
    this.avatar,
    this.honor,
    this.resume,
    this.paid,
    this.mime,
    this.favorite,
    this.uuid
  );

  factory YYLesson.fromJson(Map<String, dynamic> json) => _$YYLessonFromJson(json);

  Map<String, dynamic> toJson() => _$YYLessonToJson(this);
}
