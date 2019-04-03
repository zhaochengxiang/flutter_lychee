import 'package:json_annotation/json_annotation.dart';
import 'package:lychee/common/model/YYBanner.dart';
import 'package:lychee/common/model/YYActivity.dart';
import 'package:lychee/common/model/YYBook.dart';
import 'package:lychee/common/model/YYLesson.dart';
import 'package:lychee/common/model/YYCourse.dart';

part 'YYFrame.g.dart';

@JsonSerializable()
class YYFrame {
  double id;
  double lid;
  double uid;
  String name;

  YYFrame(
    this.id,
    this.lid,
    this.uid,
    this.name,
  );

  factory YYFrame.fromJson(Map<String, dynamic> json) => _$YYFrameFromJson(json);

  Map<String, dynamic> toJson() => _$YYFrameToJson(this);
}
