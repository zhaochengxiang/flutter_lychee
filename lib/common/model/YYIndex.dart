import 'package:json_annotation/json_annotation.dart';
import 'package:lychee/common/model/YYBanner.dart';
import 'package:lychee/common/model/YYActivity.dart';
import 'package:lychee/common/model/YYBook.dart';
import 'package:lychee/common/model/YYLesson.dart';
import 'package:lychee/common/model/YYCourse.dart';

part 'YYIndex.g.dart';

@JsonSerializable()
class YYIndex {
  List<YYBanner> bannerList;
  List<YYActivity> activityList;
  List<YYBook> chosenBookList;
  List<YYLesson> chosenLessonList;
  List<YYCourse> chosenCourseList;
  String city;

  YYIndex(
    this.bannerList,
    this.activityList,
    this.chosenBookList,
    this.city,
  );

  factory YYIndex.fromJson(Map<String, dynamic> json) => _$YYIndexFromJson(json);

  Map<String, dynamic> toJson() => _$YYIndexToJson(this);
}
