import 'dart:async';

import 'package:sqflite/sqflite.dart';
import '../SqlProvider.dart';
import 'package:lychee/common/model/Search.dart';

class SearchDbProvider extends BaseDbProvider {
  final String name = 'search';

  final String columnId = "_id";
  final String columnType = "_type";
  final String columnKeyword = "keyword";
  final String columnCreateDate = "createDate";

  int id;
  int type;
  String keyword;
  int createDate;

  SearchDbProvider();

  Map<String, dynamic> toMap(int type,String keyword,int createDate) {
    Map<String, dynamic> map = {columnType: type,columnKeyword: keyword,columnCreateDate:createDate};
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  SearchDbProvider.fromMap(Map map) {
    id = map[columnId];
    type = map[columnType];
    keyword = map[columnKeyword];
    createDate = map[columnCreateDate];
  }

  @override
  tableSqlString() {
    return tableBaseString(name, columnId) +
        '''
        $columnType int not null,
        $columnKeyword text not null,
        $columnCreateDate int not null)
      ''';
  }

  @override
  tableName() {
    return name;
  }

  Future insert(int type,String keyword) async {
    Database db = await getDataBase();

    int createDate =DateTime.now().millisecondsSinceEpoch;

    List<Map> maps =await db.query(
      name,
      columns:[columnId],
      where: "$columnType = ? AND $columnKeyword = ?",
      whereArgs: [type,keyword]
    );
    if (maps==null || maps.length==0) {
      return await db.insert(name, toMap(type,keyword,createDate));
    } else {
      return await db.update(name, 
      toMap(type,keyword,createDate),
      where: "$columnType = ? AND $columnKeyword = ?",
      whereArgs: [type,keyword]);
    }
  }

  Future<List<Search>> getSearchs(int type) async {
    Database db = await getDataBase();
    List<Map> maps = await db.query(
      name, 
      columns: [columnId, columnType,columnKeyword,columnCreateDate],
      where: "$columnType = ?",
      whereArgs: [type],
      orderBy: "$columnCreateDate DESC");
    List<Search> list = new List();
    if (maps!=null) {
      maps.forEach((map){
        SearchDbProvider provider = SearchDbProvider.fromMap(map);
        list.add(Search(provider.type,provider.keyword,provider.createDate));
      });
    }

    return list;
  }

  Future<int> deleteSearch(int type) async {
    Database db = await getDataBase();
    return await db.delete(
      name,
      where: "$columnType = ?",
      whereArgs: [type]
    );
  }
}