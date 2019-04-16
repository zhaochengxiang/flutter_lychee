import 'package:json_annotation/json_annotation.dart';
import 'package:lychee/common/model/Scholar.dart';

part 'ScholarResult.g.dart';

@JsonSerializable()
class ScholarResult {
  int total;
  int last;
  int offset;
  bool hasNext;
  List<Scholar> list;

  ScholarResult(
    this.total,
    this.last,
    this.offset,
    this.hasNext,
    this.list,
  );

  factory ScholarResult.fromJson(Map<String, dynamic> json) => _$ScholarResultFromJson(json);

  Map<String, dynamic> toJson() => _$ScholarResultToJson(this);
}
