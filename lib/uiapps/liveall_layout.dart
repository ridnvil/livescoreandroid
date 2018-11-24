import 'package:flutter/material.dart';
import 'package:livescore/materialui/cardview.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AllMatchLayout extends StatefulWidget {
  static final String tag = "/MAIN_LAYOUT";
  static String zonetimeAll;
  
  @override
  _AllMatchLayoutState createState() => _AllMatchLayoutState();
}

class _AllMatchLayoutState extends State<AllMatchLayout> {
  GlobalKey<ScaffoldState> _drawer = new GlobalKey<ScaffoldState>();
  String timeZoneAll;
  String gmtAll;
  Timer time;

  Future<String> parseTZAll() async {
    setState(() {
      timeZoneAll = AllMatchLayout.zonetimeAll;
      gmtAll = timeZoneAll.replaceAll(r'plus', '+');
    });
  }

  Future reloadTZAll(Timer time) async {
    time = Timer(Duration(milliseconds: 2000), parseTZAll);
  }

  @override
  void initState() {
    super.initState();
    AllMatchLayout.zonetimeAll = 'GMTplus7';
  }

  @override
  Widget build(BuildContext context) {
    reloadTZAll(time);
    return Scaffold(
      key: _drawer,
      endDrawer: Opacity(
        opacity: 0.9,
        child: Drawer(
          elevation: 10.0,
          child: DrawerTimeZone(locations: timeZoneAll),
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
                    title: Center(child: gmtAll == null ? Text('All Match : GMT+7',style: TextStyle(fontSize: 14.0)) : Text('All Match : ${gmtAll}',style: TextStyle(fontSize: 14.0))),
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
                  child: Container(
                      child: AllMatch(timezoneAll: AllMatchLayout.zonetimeAll),
                    ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}