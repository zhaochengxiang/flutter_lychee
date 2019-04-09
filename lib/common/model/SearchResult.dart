import 'package:json_annotation/json_annotation.dart';
import 'package:lychee/common/model/Course.dart';
import 'package:lychee/common/model/Lesson.dart';
import 'package:lychee/common/model/Book.dart';

part 'SearchResult.g.dart';

@JsonSerializable()
class SearchResult {

  List<Course> courseList;
  List<Lesson> lessonList;
  List<Book> bookList;

  SearchResult(
    this.courseList,
    this.lessonList,
    this.bookList,
  );

  factory SearchResult.fromJson(Map<String, dynamic> json) => _$SearchResultFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResultToJson(this);
}
