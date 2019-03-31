import 'package:json_annotation/json_annotation.dart';
import 'package:lychee/common/model/YYCourse.dart';

part 'YYCourseHome.g.dart';

@JsonSerializable()
class YYCourseHome {
  List<YYCourse> recommendList;
  List<YYCourse> fineList;

  YYCourseHome(
    this.recommendList,
    this.fineList,
  );

  factory YYCourseHome.fromJson(Map<String, dynamic> json) => _$YYCourseHomeFromJson(json);

  Map<String, dynamic> toJson() => _$YYCourseHomeToJson(this);
}
