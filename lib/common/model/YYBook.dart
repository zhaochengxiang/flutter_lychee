import 'package:json_annotation/json_annotation.dart';

part 'YYBook.g.dart';

@JsonSerializable()
class YYBook {
  double id;
  double oid;
  String uuid;
  String isbn;
  /**
   * 书名
   */
  String title;
  /**
   *
   */
  String author;
  /**
   * 出版时间
   */
  String date;
  /**
   * 封面图片ID
   */
  String cover;
  /**
   * 中图分类
   */
  String category;
  /**
   * 内容摘要
   */
  String summary;
  /**
   * 出版单位
   */
  String press;
  /**
   * 想读
   */
  int wantReadQuantity;
  /**
   * 已读
   */
  int haveReadQuantity;
  /**
   * 收藏
   */
  int collectionQuantity;
  /**
   * 笔记
   */
  int noteQuantity;
  /**
   * 错误提示信息
   */
  String error;
  /**
   * 是否共享
   */
  //    private int shared;
  bool selected;

  YYBook(
    this.id,
    this.oid,
    this.uuid,
    this.isbn,
    this.title,
    this.author,
    this.date,
    this.cover,
    this.category,
    this.summary,
    this.press,
    this.wantReadQuantity,
    this.haveReadQuantity,
    this.collectionQuantity,
    this.noteQuantity,
    this.error,
    this.selected,
  );

  factory YYBook.fromJson(Map<String, dynamic> json) => _$YYBookFromJson(json);

  Map<String, dynamic> toJson() => _$YYBookToJson(this);
}
