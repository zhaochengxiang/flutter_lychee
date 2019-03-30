import 'package:json_annotation/json_annotation.dart';
import 'package:lychee/common/model/YYCourse.dart';
import 'package:lychee/common/model/YYLesson.dart';
import 'package:lychee/common/model/YYBook.dart';

part 'YYScholar.g.dart';

@JsonSerializable()
class YYScholar {
   double id;
   int type;
   String name;
   int verified;
   String avatar;
   String honor;
   String resume;
   bool followed;
   List<YYCourse> courseList;
   List<YYLesson> lessonList;
   List<YYBook> bookList;

  YYScholar(
    this.id,
    this.type,
    this.name,
    this.verified,
    this.avatar,
    this.honor,
    this.resume,
    this.followed,
    this.courseList,
    this.lessonList,
    this.bookList,
  );

  factory YYScholar.fromJson(Map<String, dynamic> json) => _$YYScholarFromJson(json);

  Map<String, dynamic> toJson() => _$YYScholarToJson(this);
}
