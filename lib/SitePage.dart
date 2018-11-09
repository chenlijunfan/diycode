import 'dart:async';
import 'dart:convert';

import 'package:diycode/bean/SiteBean.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SitePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new SiteState();
  }
}

class SiteState extends State<SitePage> {
  List<SiteBean> list = <SiteBean>[];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView(children: <Widget>[
      Column(mainAxisAlignment: MainAxisAlignment.start, children: _getItems())
    ]);
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  List<Widget> _getItems() {
    List<Widget> items = <Widget>[];
    for (int i = 0; i < list.length; i++) {
      items.add(new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(list[i].name,
              style: new TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                  decoration: TextDecoration.none)),
          new Column(
            children: _buildItem(list[i].sites),
          )
          /* _createArticleItem(list[i].sites[1]),
          _createArticleItem(list[i].sites[2]),
          _createArticleItem(list[i].sites[3]),*/
        ],
      ));
    }
    return items;
  }

  int itemCount() {
    if (this.list.length > 0) {
      return this.list.length;
    }

    return 0;
  }

  List<Widget> _buildItem(List<SiteDetaiBean> datas) {
    List<Widget> list = <Widget>[];
    for (int i = 0; i < datas.length - 1; i = i + 2) {
      list.add(_createArticleItem(datas[i], datas[i + 1]));
    }
    return list;
  }

  _createArticleItem(SiteDetaiBean sit, SiteDetaiBean sit2) {
    return (new Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Image.network(
                  sit.avatar_url,
                  height: 25.0,
                  width: 25.0,
                  fit: BoxFit.contain,
                ),
                new Text(
                  sit.name,
                  style: new TextStyle(
                      color: Colors.black,
                      fontSize: 10.0,
                      decoration: TextDecoration.none),
                )
              ],
            )),
        GestureDetector(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Image.network(
                  sit2.avatar_url,
                  height: 25.0,
                  width: 25.0,
                ),
                new Text(
                  sit2.name,
                  style: new TextStyle(
                      color: Colors.black,
                      fontSize: 10.0,
                      decoration: TextDecoration.none),
                )
              ],
            ))
      ],
    ));
  }

  Future<Null> _getData() async {
    final Completer<Null> completer = new Completer<Null>();
    var url = "https://diycode.cc/api/v3/sites.json";
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        Utf8Decoder decode = new Utf8Decoder();
        var data = new SiteListBean()
            .fromJson(jsonDecode(decode.convert(response.bodyBytes)));
        list.addAll(data);
      }
    } catch (exception) {
      print(exception);
    }
    completer.complete(null);
    setState(() {});

    return completer.future;
  }
}
