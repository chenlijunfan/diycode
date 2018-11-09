import 'dart:convert';

import 'package:diycode/BottomTab.dart';
import 'package:diycode/bean/LocalSp.dart';
import 'package:diycode/bean/Token.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Container(child: new BottomTab()),
    );
  }

  void _getToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    Map<String, String> query = new Map();
    query.addAll({
      "client_id": "8139cc59",
      "client_secret":
          "7614ffb5cd11b1b044180c1fd26ed23ecb34bb8360290ab1b759884ad3fedfdc",
      "grant_type": "refresh_token",
      "refresh_token": sp.getString(SPKey.TOKEN)
    });
    try {
      var response = await http
          .post(Uri.https("https://www.diycode.cc", "/oauth/token", query));
      if (response.statusCode == 200) {
        var token = Token.fromJson(json.decode(response.body));
        sp.setString(SPKey.TOKEN, token.access_token);
      }
    } catch (exception) {}
  }
}
