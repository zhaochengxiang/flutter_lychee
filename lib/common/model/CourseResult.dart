import 'package:json_annotation/json_annotation.dart';
import 'package:lychee/common/model/Course.dart';
part 'CourseResult.g.dart';

@JsonSerializable()
class CourseResult {
  int total;
  int last;
  int offset;
  bool hasNext;
  List<Course> list;

  CourseResult(
    this.total,
    this.last,
    this.offset,
    this.hasNext,
    this.list,
  );

  factory CourseResult.fromJson(Map<String, dynamic> json) => _$CourseResultFromJson(json);

  Map<String, dynamic> toJson() => _$CourseResultToJson(this);
}
