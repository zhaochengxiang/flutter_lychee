import 'package:json_annotation/json_annotation.dart';
import 'package:lychee/common/model/YYBookResult.dart';

part 'YYMember.g.dart';

@JsonSerializable()
class YYMember {
  static int STATE_UNKNOWN = -1;
  static int STATE_DISABLE =0;
  static int STATE_ENABLE = 1;
  static int ROLE_UNKNOWN = -1;
  static int ROLE_NON = 0;
  static int ROLE_COMMON = 1;
  static int ROLE_ASSISTANT = 2;
  static int ROLE_MANAGER = 3;

  double id;
  double lid;
  double uid;
  int state;
  int role;
  String department;
  String username;
  int borrowedQuantity;
  int borrowingQuantity;
  String avatar;
  bool revisable;
  YYBookResult sharingBooks;
  YYBookResult borrowingBooks;

  YYMember(
    this.id,
    this.lid,
    this.uid,
    this.state,
    this.role,
    this.department,
    this.username,
    this.borrowedQuantity,
    this.borrowingQuantity,
    this.avatar,
    this.revisable,
    this.sharingBooks,
    this.borrowingBooks,
  );

  factory YYMember.fromJson(Map<String, dynamic> json) => _$YYMemberFromJson(json);

  Map<String, dynamic> toJson() => _$YYMemberToJson(this);
}
