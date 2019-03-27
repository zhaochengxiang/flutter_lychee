import 'package:json_annotation/json_annotation.dart';
import 'package:lychee/common/model/YYBook.dart';

part 'YYBookHome.g.dart';

@JsonSerializable()
class YYBookHome {
  List<YYBook> fineList;
  List<YYBook> latestList;
  List<YYBook> topPopularList;


  YYBookHome(
    this.fineList,
    this.latestList,
    this.topPopularList,
  );

  factory YYBookHome.fromJson(Map<String, dynamic> json) => _$YYBookHomeFromJson(json);

  Map<String, dynamic> toJson() => _$YYBookHomeToJson(this);
}
