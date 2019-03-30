import 'package:json_annotation/json_annotation.dart';
import 'package:lychee/common/model/YYBook.dart';

part 'YYBookResult.g.dart';

@JsonSerializable()
class YYBookResult {
  int total;
  double last;
  int offset;
  List<YYBook> bookList;

  YYBookResult(
    this.total,
    this.last,
    this.offset,
    this.bookList,
  );

  factory YYBookResult.fromJson(Map<String, dynamic> json) => _$YYBookResultFromJson(json);

  Map<String, dynamic> toJson() => _$YYBookResultToJson(this);
}
