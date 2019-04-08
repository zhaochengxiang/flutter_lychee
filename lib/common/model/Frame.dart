import 'package:json_annotation/json_annotation.dart';
import 'package:lychee/common/model/Banner.dart';
import 'package:lychee/common/model/Activity.dart';
import 'package:lychee/common/model/Book.dart';
import 'package:lychee/common/model/Lesson.dart';
import 'package:lychee/common/model/Course.dart';

part 'Frame.g.dart';

@JsonSerializable()
class Frame {
  int id;
  int lid;
  int uid;
  String name;

  Frame(
    this.id,
    this.lid,
    this.uid,
    this.name,
  );

  factory Frame.fromJson(Map<String, dynamic> json) => _$FrameFromJson(json);

  Map<String, dynamic> toJson() => _$FrameToJson(this);
}
