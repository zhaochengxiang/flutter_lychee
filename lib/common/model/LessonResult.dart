import 'package:json_annotation/json_annotation.dart';
import 'package:lychee/common/model/Lesson.dart';
part 'LessonResult.g.dart';

@JsonSerializable()
class LessonResult {
  int total;
  int last;
  int offset;
  bool hasNext;
  List<Lesson> list;

  LessonResult(
    this.total,
    this.last,
    this.offset,
    this.hasNext,
    this.list,
  );

  factory LessonResult.fromJson(Map<String, dynamic> json) => _$LessonResultFromJson(json);

  Map<String, dynamic> toJson() => _$LessonResultToJson(this);
}
