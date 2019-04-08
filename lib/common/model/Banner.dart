import 'package:json_annotation/json_annotation.dart';

part 'Banner.g.dart';

@JsonSerializable()
class Banner {
  String image;
  String link;

  Banner(
    this.image,
    this.link,
  );

  factory Banner.fromJson(Map<String, dynamic> json) => _$BannerFromJson(json);

  Map<String, dynamic> toJson() => _$BannerToJson(this);
}
