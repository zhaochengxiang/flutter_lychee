import 'package:json_annotation/json_annotation.dart';
import 'package:lychee/common/model/Banner.dart';
import 'package:lychee/common/model/Activity.dart';
import 'package:lychee/common/model/Book.dart';
import 'package:lychee/common/model/Lesson.dart';
import 'package:lychee/common/model/Course.dart';

part 'Index.g.dart';

@JsonSerializable()
class Index {
  List<Banner> bannerList;
  List<Activity> activityList;
  List<Book> chosenBookList;
  List<Lesson> chosenLessonList;
  List<Course> chosenCourseList;
  String city;

  Index(
    this.bannerList,
    this.activityList,
    this.chosenBookList,
    this.city,
  );

  factory Index.fromJson(Map<String, dynamic> json) => _$IndexFromJson(json);

  Map<String, dynamic> toJson() => _$IndexToJson(this);
}
