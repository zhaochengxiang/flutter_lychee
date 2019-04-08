import 'package:json_annotation/json_annotation.dart';
import 'package:lychee/common/model/Book.dart';

part 'BookHome.g.dart';

@JsonSerializable()
class BookHome {
  List<Book> fineList;
  List<Book> latestList;
  List<Book> topPopularList;


  BookHome(
    this.fineList,
    this.latestList,
    this.topPopularList,
  );

  factory BookHome.fromJson(Map<String, dynamic> json) => _$BookHomeFromJson(json);

  Map<String, dynamic> toJson() => _$BookHomeToJson(this);
}
