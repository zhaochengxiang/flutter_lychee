import 'package:json_annotation/json_annotation.dart';
import 'package:lychee/common/model/Lesson.dart';

part 'LessonHome.g.dart';

@JsonSerializable()
class LessonHome {
  List<Lesson> recommendList;
  List<Lesson> fineList;

  LessonHome(
    this.recommendList,
    this.fineList,
  );

  factory LessonHome.fromJson(Map<String, dynamic> json) => _$LessonHomeFromJson(json);

  Map<String, dynamic> toJson() => _$LessonHomeToJson(this);
}
