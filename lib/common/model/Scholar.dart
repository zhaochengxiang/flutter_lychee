import 'package:json_annotation/json_annotation.dart';
import 'package:lychee/common/model/Course.dart';
import 'package:lychee/common/model/Lesson.dart';
import 'package:lychee/common/model/Book.dart';

part 'Scholar.g.dart';

@JsonSerializable()
class Scholar {
   int id;
   int type;
   String name;
   int verified;
   String avatar;
   String honor;
   String resume;
   bool followed;
   List<Course> courseList;
   List<Lesson> lessonList;
   List<Book> bookList;

  Scholar({
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
    this.bookList
  });

  factory Scholar.fromJson(Map<String, dynamic> json) => _$ScholarFromJson(json);

  Map<String, dynamic> toJson() => _$ScholarToJson(this);
}
