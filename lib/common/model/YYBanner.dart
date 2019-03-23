import 'package:json_annotation/json_annotation.dart';

part 'YYBanner.g.dart';

@JsonSerializable()
class YYBanner {
  String image;
  String link;

  YYBanner(
    this.image,
    this.link,
  );

  factory YYBanner.fromJson(Map<String, dynamic> json) => _$YYBannerFromJson(json);

  Map<String, dynamic> toJson() => _$YYBannerToJson(this);
}
