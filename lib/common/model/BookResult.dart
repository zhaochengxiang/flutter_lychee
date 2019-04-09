import 'package:json_annotation/json_annotation.dart';
import 'package:lychee/common/model/Book.dart';
part 'BookResult.g.dart';

@JsonSerializable()
class BookResult {
  int total;
  int last;
  int offset;
  bool hasNext;
  List<Book> list;

  BookResult(
    this.total,
    this.last,
    this.offset,
    this.hasNext,
    this.list,
  );

  factory BookResult.fromJson(Map<String, dynamic> json) => _$BookResultFromJson(json);

  Map<String, dynamic> toJson() => _$BookResultToJson(this);
}
