import 'package:json_annotation/json_annotation.dart';
import 'package:lychee/common/model/Receipt.dart';
import 'package:lychee/common/model/Copy.dart';
import 'package:lychee/common/model/Member.dart';

part 'Library.g.dart';

@JsonSerializable()
class Library {
  static int TYPE_COMMUNITY = 0;
  static int TYPE_GROUP = 1;
  static int TYPE_ORGANIZE = 2;

  int id;
  String name;
  int type;
  int state;
  int openJoin;
  int openApply;
  int enableInvite;
  int openSearch;
  int openQuit;
  int openShare;
  int openProfile;
  int enableIndex;
  int enableDismiss;
  int professional;
  String address;
  String phone;
  String province;
  String city;
  String cityCode;
  String addressCode;
  String district;
  int distance;
  double intitude;
  double latitude;
  List<Receipt> receiptList;
  List<Copy> copyList;
  Member myself;
  int bookQuantity;
  int memberQuantity;
  int readingQuantity;
  int borrowedQuantity;
  int borrowingQuantity;
  String announcement;
  int borrowQuantity;
  int borrowDay;
  bool located;
  bool expanded;

  Library(
    this.id,
    this.name,
    this.type,
    this.state,
    this.openJoin,
    this.openApply,
    this.enableInvite,
    this.openSearch,
    this.openQuit,
    this.openShare,
    this.openProfile,
    this.enableIndex,
    this.enableDismiss,
    this.professional,
    this.address,
    this.phone,
    this.province,
    this.city,
    this.cityCode,
    this.addressCode,
    this.district,
    this.distance,
    this.intitude,
    this.latitude,
    this.receiptList,
    this.copyList,
    this.myself,
    this.bookQuantity,
    this.memberQuantity,
    this.readingQuantity,
    this.borrowedQuantity,
    this.borrowingQuantity,
    this.announcement,
    this.borrowQuantity,
    this.borrowDay,
    this.located,
    this.expanded,
  );

  factory Library.fromJson(Map<String, dynamic> json) => _$LibraryFromJson(json);

  Map<String, dynamic> toJson() => _$LibraryToJson(this);
}
