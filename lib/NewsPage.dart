import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:diycode/bean/NewsBean.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new NewsPageState();
  }
}

class NewsPageState extends State<NewsPage> {
  final TrackingScrollController _scrollController =
      new TrackingScrollController();

  List<NewsBean> list = <NewsBean>[];

  // 是否有下一页
  bool isMore = false;
  bool isLoading = false;
  int pageNum = 0;
  int pageSize = 20;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new NotificationListener(
      onNotification: _onNotification,
      child: new ListView.builder(
          controller: _scrollController,
          physics: new AlwaysScrollableScrollPhysics(),
          itemCount: itemCount(),
          itemBuilder: (_, int index) => _createItem(context, index)),
    );
  }

  @override
  void initState() {
    super.initState();

    _loadMoreData();
  }

  bool _onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      // print('max:${_scrollController.mostRecentlyUpdatedPosition.maxScrollExtent}  offset:${_scrollController.offset}');
      // 当没去到底部的时候，maxScrollExtent和offset会相等
      if (_scrollController.mostRecentlyUpdatedPosition.maxScrollExtent >
              _scrollController.offset &&
          _scrollController.mostRecentlyUpdatedPosition.maxScrollExtent -
                  _scrollController.offset <=
              50) {
        // 要加载更多
        if (this.isMore && !this.isLoading) {
          // 有下一页
          _loadMoreData();
          setState(() {});
        } else {}
      }
      return true;
    }
  }

  int itemCount() {
    if (this.list.length > 0) {
      return this.list.length + 1;
    }

    return 0;
  }

  _createItem(BuildContext context, int index) {
    if (index < list.length) {
      return _createArticleItem(context, index);
    }

    return new Container(
      height: 40.0,
      child: new Center(
        child: new Text(
          _getLoadMoreString(),
          style: new TextStyle(
              fontSize: 12.0,
              color: Colors.black,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  String _getLoadMoreString() {
    if (this.isMore && !this.isLoading) {
      return '上拉加载更多';
    } else if (!this.isMore) {
      return '没有更多了';
    } else {
      return '加载中...';
    }
  }

  _createArticleItem(BuildContext context, int index) {
    String url = list[index].user.avatar_url;
    String url2 = url;
    if (url.contains("diycode")) // 添加判断，防止替换掉其他网站掉图片
      url2 = url.replaceAll("large_avatar", "avatar");
    return (new GestureDetector(
        onTap: () {
          Dialog(child: Text("点击了"));
        },
        child: new Container(
          padding: EdgeInsets.only(top: 12.0, left: 12.0),
          color: Colors.white,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _topMessage(url2, list[index]),
              _title(list[index]),
              _date(list[index].created_at),
            ],
          ),
        )));
  }

  Future<Null> _loadMoreData() {
    return _getData();
  }

  Future<Null> _getData() async {
    this.isLoading = true;
    final Completer<Null> completer = new Completer<Null>();

    var url = "https://diycode.cc/api/v3/news.json?offset=" +
        (pageNum * pageSize + 1).toString() +
        "&limit=20";
    Map<String, String> query = new Map();
    query.addAll({
      "node_id": null,
      "offset": (pageSize * pageNum).toString(),
      "limit": pageSize.toString()
    });

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        pageNum++;
        Utf8Decoder decode = new Utf8Decoder();
        var data = new NewsListBean()
            .fromJson(jsonDecode(decode.convert(response.bodyBytes)));
        list.addAll(data);
        if (data.length <= 0) {
          this.isMore = false;
        } else {
          this.isMore = true;
        }
      }
    } catch (exception) {
      print(exception);
    }

    this.isLoading = false;
    completer.complete(null);
    setState(() {});

    return completer.future;
  }

  _topMessage(String url2, NewsBean newsBean) {
    return new Container(
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          new Image.network(
            url2,
            height: 25.0,
            width: 25.0,
          ),
          new Text(" " + newsBean.user.login,
              style: new TextStyle(
                  fontSize: 12.0,
                  decoration: TextDecoration.none,
                  color: Colors.grey)),
          new Text(
            " - " + newsBean.node_name,
            style: new TextStyle(
                fontSize: 12.0,
                decoration: TextDecoration.none,
                color: Colors.grey),
          ),
        ],
      ),
    );
  }

  _title(NewsBean newsBean) {
    return new Text(
      newsBean.title,
      style: new TextStyle(
          fontSize: 14.0, color: Colors.black, decoration: TextDecoration.none),
    );
  }

  _date(String created_at) {
    return new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            created_at,
            style: new TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
                decoration: TextDecoration.none),
          ),
          new Container(
            padding: EdgeInsets.only(top: 12.0),
            child: new Divider(
              height: 0.5,
            ),
          )
        ]);
  }
}
