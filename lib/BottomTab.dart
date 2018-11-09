import 'package:diycode/MyPage.dart';
import 'package:diycode/NewsPage.dart';
import 'package:diycode/SitePage.dart';
import 'package:diycode/TopicPage.dart';
import 'package:flutter/material.dart';

class BottomTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new BottomTabBarState();
  }
}

class BottomTabBarState extends State<BottomTab> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new Container(
        child: new Text("哈哈，就是来搞笑的"),
      ),
      appBar: new AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          'images/logo_actionbar.png',
          height: 30.0,
        ),
      ),
      body: new Stack(
        children: <Widget>[
          /// Offstage 这个widget 在offstage条件为假的时候，不会显示，不会响应事件，不会占用任何的父widget的空间
          new Offstage(
            // offstage参数是一个bool类型，表示是否要显示这个widget
            offstage: _currentIndex != 0,
            child: new TickerMode(
              enabled: _currentIndex == 0,
              child: new TopicPage(),
            ),
          ),
          new Offstage(
            offstage: _currentIndex != 1,
            child: new TickerMode(
              enabled: _currentIndex == 1,
              child: new NewsPage(),
            ),
          ),
          new Offstage(
            offstage: _currentIndex != 2,
            child: new TickerMode(
              enabled: _currentIndex == 2,
              child: new SitePage(),
            ),
          ),
          new Offstage(
            offstage: _currentIndex != 3,
            child: new TickerMode(
              enabled: _currentIndex == 3,
              child: new MyPage(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: new BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
              icon: new Icon(Icons.domain), title: new Text('TOPICS')),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.book), title: new Text('NEWS')),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.ac_unit), title: new Text('SITES')),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.home), title: new Text('MY')),
        ],
        // 可以改变这个来设置初始的时候显示哪个tab
        currentIndex: _currentIndex,
        onTap: (int index) {
          // 这里点击tab上的item后，会执行，setState来刷新选中状态
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
