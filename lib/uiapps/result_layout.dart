import 'package:flutter/material.dart';
import 'package:livescore/materialui/cardview.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ResultLayout extends StatefulWidget {
  static final String tag = "/MAIN_LAYOUT";
  static String zonetimeResult;
  @override
  _ResultLayoutState createState() => _ResultLayoutState();
}

class _ResultLayoutState extends State<ResultLayout> {
  GlobalKey<ScaffoldState> _drawer = new GlobalKey<ScaffoldState>();
  String timeZoneResult;
  String gmtResult;
  Timer time;

  Future<String> parseTZResult() async {
    setState(() {
      timeZoneResult = ResultLayout.zonetimeResult;
      gmtResult = timeZoneResult.replaceAll(r'plus', '+');
    });
  }

  Future reloadTZResult(Timer time) async {
    time = Timer(Duration(milliseconds: 2000), parseTZResult);
  }

  @override
  void initState() {
    super.initState();
    ResultLayout.zonetimeResult = 'GMTplus7';
  }

  @override
  Widget build(BuildContext context) {
    reloadTZResult(time);
    return Scaffold(
      key: _drawer,
      endDrawer: Opacity(
        opacity: 0.9,
        child: Drawer(
          elevation: 10.0,
          child: DrawerTimeZone(locations: timeZoneResult),
        ),
      ),
      body: Container(
        child: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Image(
              image: new AssetImage("assets/bgls.png"),
              fit: BoxFit.cover,
              color: Colors.black54,
              colorBlendMode: BlendMode.darken,
            ),
            Column(
              children: <Widget>[
                new Container(
                  child: AppBar(
                    title: Center(child: gmtResult == null ? Text('Result : GMT+7',style: TextStyle(fontSize: 14.0)) : Text('Result : ${gmtResult}',style: TextStyle(fontSize: 14.0))),
                    actions: <Widget>[
                      new IconButton(
                        icon: Icon(Icons.av_timer),
                        onPressed: () => _drawer.currentState.openEndDrawer(),
                      )
                    ],
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Expanded(
                    child: LiveMatch(
                        timezoneLive: ResultLayout.zonetimeResult,
                        page: 0)
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
