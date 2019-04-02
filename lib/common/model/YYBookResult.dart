import 'package:json_annotation/json_annotation.dart';
import 'package:lychee/common/model/YYBook.dart';

part 'YYBookResult.g.dart';

@JsonSerializable()
class YYBookResult {
  int total;
  double last;
  int offset;
  bool hasNext;
  List<YYBook> list;

  YYBookResult(
    this.total,
    this.last,
    this.offset,
    this.hasNext,
    this.list,
  );

  factory YYBookResult.fromJson(Map<String, dynamic> json) => _$YYBookResultFromJson(json);

  Map<String, dynamic> toJson() => _$YYBookResultToJson(this);
}
