import 'package:json_annotation/json_annotation.dart';

part 'Search.g.dart';

@JsonSerializable()
class Search {
  static int SEARCH_COMPOSITE = 0;
  static int SEARCH_BOOK = 1;
  static int SEARCH_LESSON = 2;
  static int SEARCH_COURSE = 3;
  static int SEARCH_LIBRARY = 4;
  static int SEARCH_UID = 5;
  static int SEARCH_PHONE = 6;

  int type;
  String keyword;
  int createDate;

  Search(
    this.type,
    this.keyword,
    this.createDate,
  );

  factory Search.fromJson(Map<String, dynamic> json) => _$SearchFromJson(json);

  Map<String, dynamic> toJson() => _$SearchToJson(this);
}
