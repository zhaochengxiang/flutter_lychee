import 'package:json_annotation/json_annotation.dart';
import 'package:lychee/common/model/Book.dart';
import 'package:lychee/common/model/Library.dart';
import 'package:lychee/common/model/Copy.dart';
import 'package:lychee/common/model/Scholar.dart';
part 'RichBook.g.dart';

@JsonSerializable()
class RichBook {
    Book book;
    bool wantRead;
    List<Book> favoriteList;
    List<Library> libraryList;
    List<Copy> copyList;
    List<Scholar> scholarList;

  RichBook(
    this.book,
    this.wantRead,
    this.favoriteList,
    this.libraryList,
    this.copyList,
    this.scholarList,
  );

  factory RichBook.fromJson(Map<String, dynamic> json) => _$RichBookFromJson(json);

  Map<String, dynamic> toJson() => _$RichBookToJson(this);
}
