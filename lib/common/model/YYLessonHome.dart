import 'package:json_annotation/json_annotation.dart';
import 'package:lychee/common/model/YYLesson.dart';

part 'YYLessonHome.g.dart';

@JsonSerializable()
class YYLessonHome {
  List<YYLesson> recommendList;
  List<YYLesson> fineList;

  YYLessonHome(
    this.recommendList,
    this.fineList,
  );

  factory YYLessonHome.fromJson(Map<String, dynamic> json) => _$YYLessonHomeFromJson(json);

  Map<String, dynamic> toJson() => _$YYLessonHomeToJson(this);
}
