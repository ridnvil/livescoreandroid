import 'package:flutter/material.dart';
import 'package:livescore/materialui/cardview.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ResultLayout extends StatefulWidget {
  static String zonetime;
  @override
  _ResultLayoutState createState() => _ResultLayoutState();
}

class _ResultLayoutState extends State<ResultLayout> {
  GlobalKey<ScaffoldState> _drawer = new GlobalKey<ScaffoldState>();
  String timeZone = 'GMTplus7';
  String gmt;
  Timer time;

  Future<String> parseTZ() async {
    setState(() {
      timeZone = ResultLayout.zonetime;
      gmt = timeZone.replaceAll(r'plus', '+');
    });
  }

  Future reloadTZ(Timer time) async {
    time = Timer(Duration(milliseconds: 5000), parseTZ);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    reloadTZ(time);
    return Scaffold(
      key: _drawer,
      endDrawer: Opacity(
        opacity: 0.9,
        child: Drawer(
          elevation: 10.0,
          child: DrawerTimeZone(locations: timeZone),
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
                    title: Center(child: gmt == null ? Text('Result : GMT+7',style: TextStyle(fontSize: 14.0)) : Text('Result : ${gmt}',style: TextStyle(fontSize: 14.0))),
                    actions: <Widget>[
                      new IconButton(
                        icon: Icon(Icons.av_timer),
                        onPressed: () => _drawer.currentState.openEndDrawer(),
                      )
                    ],
                    backgroundColor: Colors.transparent,
                  ),
                ),
                new Container(
                  height: 512.0,
                  padding: EdgeInsets.all(10.0),
                  child: ResultMatch(timezone: timeZone),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
