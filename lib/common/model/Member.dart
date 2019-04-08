import 'package:json_annotation/json_annotation.dart';
import 'package:lychee/common/model/BookResult.dart';

part 'Member.g.dart';

@JsonSerializable()
class Member {
  static int STATE_UNKNOWN = -1;
  static int STATE_DISABLE =0;
  static int STATE_ENABLE = 1;
  static int ROLE_UNKNOWN = -1;
  static int ROLE_NON = 0;
  static int ROLE_COMMON = 1;
  static int ROLE_ASSISTANT = 2;
  static int ROLE_MANAGER = 3;

  int id;
  int lid;
  int uid;
  int state;
  int role;
  String department;
  String username;
  int borrowedQuantity;
  int borrowingQuantity;
  String avatar;
  bool revisable;
  BookResult sharingBooks;
  BookResult borrowingBooks;

  Member(
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

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  Map<String, dynamic> toJson() => _$MemberToJson(this);
}
