import 'package:json_annotation/json_annotation.dart';
import 'package:lychee/common/model/Course.dart';

part 'CourseHome.g.dart';

@JsonSerializable()
class CourseHome {
  List<Course> recommendList;
  List<Course> fineList;

  CourseHome(
    this.recommendList,
    this.fineList,
  );

  factory CourseHome.fromJson(Map<String, dynamic> json) => _$CourseHomeFromJson(json);

  Map<String, dynamic> toJson() => _$CourseHomeToJson(this);
}
