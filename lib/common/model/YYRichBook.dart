import 'package:json_annotation/json_annotation.dart';
import 'package:lychee/common/model/YYBook.dart';
import 'package:lychee/common/model/YYLibrary.dart';
import 'package:lychee/common/model/YYCopy.dart';
import 'package:lychee/common/model/YYScholar.dart';
part 'YYRichBook.g.dart';

@JsonSerializable()
class YYRichBook {
    YYBook book;
    bool wantRead;
    List<YYBook> favoriteList;
    List<YYLibrary> libraryList;
    List<YYCopy> copyList;
    List<YYScholar> scholarList;

  YYRichBook(
    this.book,
    this.wantRead,
    this.favoriteList,
    this.libraryList,
    this.copyList,
    this.scholarList,
  );

  factory YYRichBook.fromJson(Map<String, dynamic> json) => _$YYRichBookFromJson(json);

  Map<String, dynamic> toJson() => _$YYRichBookToJson(this);
}
