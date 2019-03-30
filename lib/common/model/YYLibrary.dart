import 'package:json_annotation/json_annotation.dart';
import 'package:lychee/common/model/YYReceipt.dart';
import 'package:lychee/common/model/YYCopy.dart';
import 'package:lychee/common/model/YYMember.dart';

part 'YYLibrary.g.dart';

@JsonSerializable()
class YYLibrary {
  static int TYPE_COMMUNITY = 0;
  static int TYPE_GROUP = 1;
  static int TYPE_ORGANIZE = 2;

  double id;
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
  double doubleitude;
  double latitude;
  List<YYReceipt> receiptList;
  List<YYCopy> copyList;
  YYMember myself;
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

  YYLibrary(
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
    this.doubleitude,
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

  factory YYLibrary.fromJson(Map<String, dynamic> json) => _$YYLibraryFromJson(json);

  Map<String, dynamic> toJson() => _$YYLibraryToJson(this);
}
