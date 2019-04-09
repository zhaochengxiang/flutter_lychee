import 'package:flutter/material.dart';
import 'package:lychee/widget/InputWidget.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/style/Style.dart';
import 'package:lychee/common/db/provider/SearchDbProvider.dart';
import 'package:lychee/common/model/Search.dart';

typedef SearchCallback = void Function(String keyword);

class SearchPage extends StatefulWidget {
  final int type;
  final SearchCallback onPressed;

  SearchPage({this.type = 0,this.onPressed});

  @override
  _SearchPagetState createState() => new _SearchPagetState();
}

class _SearchPagetState extends State<SearchPage> {
  
  List searchs = new List();
  final TextEditingController searchController = new TextEditingController();
  final SearchDbProvider provider = SearchDbProvider();

  _hint() {
    if (widget.type == Search.SEARCH_UID) {
      return '学号';
    } else if (widget.type == Search.SEARCH_PHONE) {
      return '手机号';
    } else {
      return '请输入搜索内容';
    }
  }

  @override
  void initState(){
    super.initState();
    provider.getSearchs(widget.type).then((value) {
      setState(() {
        searchs = value;
      });
    });
  }

  _buildWrapChildren(context) {
    List<Widget> widgets = [];
    searchs.forEach((search) {
      widgets.add(new InkWell(
        onTap: () async {
          await provider.insert(widget.type, search.keyword);
          CommonUtils.closePage(context);
          widget.onPressed?.call(search.keyword);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            border: new Border.all(color: Color(YYColors.primary), width: 0.5),
          ),
          child: Padding( 
            padding:EdgeInsets.only(left: 10.5,right: 10.5,top: 5.0,bottom: 5.0),
            child: Text(search.keyword,style:TextStyle(color: Color(YYColors.primary),fontSize: YYSize.large),textAlign: TextAlign.center,)
          ),
        )
      ));
    });

    return widgets;
  }

  _searchDone(context,value) async {
    if (value==null || value.length==0) return;

    await provider.insert(widget.type, value);
    CommonUtils.closePage(context);
    widget.onPressed?.call(value);
  }

  _clearHistory() {
    provider.deleteSearch(widget.type).then((value) {
      if (value != 0) {
        setState(() {
         searchs = [];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: FlatButton(
          padding: EdgeInsets.all(0), 
          child: Image.asset(CommonUtils.Local_Icon_prefix+"back.png",width: 18,height: 18),
          onPressed: (){
            CommonUtils.closePage(context);
          },
        ),
        title: Container(   
          height: 31,
          color: Color(YYColors.gray_light),
          child: Stack(
            children: <Widget>[
              Container(
                height: 31,
                color: Color(YYColors.gray_light),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: -6.5,
                child: Row(
                children: <Widget>[
                  SizedBox(width: 5.0),
                  Image.asset(CommonUtils.Local_Icon_prefix+'search_gray.png',width: 13,height: 14,fit: BoxFit.fill),
                  SizedBox(width: 5.0),
                  Expanded(
                    child: InputWidget(
                      textStyle: TextStyle(color: Color(YYColors.secondaryText),fontSize: YYSize.tip),
                      autofocus: true,
                      hintText: _hint(),
                      onChanged: (String value) {
              
                      },
                      onSubmitted: (String value) {
                        _searchDone(context,value);
                      },
                      controller: searchController,
                    ),                       
                  ),
                  SizedBox(width: 5.0)
                ],
                ),
              )
            ],
          )
        ),
      ),
      body: SafeArea(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width:MediaQuery.of(context).size.width,
              height: 31,
              color: Color(YYColors.gray_light),
              child: Padding(
                padding: EdgeInsets.only(left: 10.5,right: 10.5),
                child: Align( 
                  alignment: Alignment.centerLeft,
                  child: Text("搜索历史",style:TextStyle(color: Color(YYColors.secondarySection),fontSize: YYSize.tip),overflow: TextOverflow.ellipsis)
                )
              )
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.5),
                alignment: Alignment.topLeft,
                child: Wrap(
                  spacing: 10.5,
                  runSpacing: 5.0,
                  children: _buildWrapChildren(context),
               )
              ),
            ),
            FlatButton(
              padding: EdgeInsets.zero,
              onPressed: (){_clearHistory();},
              child: Container(
                height: 47,
                color: Color(YYColors.gray_light),
                child: Center(
                  child: Text("清空历史",style:TextStyle(color: Color(YYColors.secondarySection),fontSize: YYSize.tip),overflow: TextOverflow.ellipsis)
                )
              )
            )
          ],
        ),
      ),
    );
  }
}
