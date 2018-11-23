import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:livescore/materialui/cardview.dart';
import 'package:livescore/materialui/timezone.dart';
import 'package:timezone/timezone.dart';
import 'package:timezone/standalone.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'dart:async';
import 'dart:convert';

class HomeLayout extends StatefulWidget {
  static final String tag = "/MAIN_LAYOUT";
  static String zonetimeLive;

  const HomeLayout({Key key}) : super(key: key);
  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  GlobalKey<ScaffoldState> _drawer = new GlobalKey<ScaffoldState>();

  List<String> list;
  String timeZoneHome;
  Timer time;
  String gmt;

  Future<String> parseTZ() async {
    setState(() {
      timeZoneHome =  HomeLayout.zonetimeLive;
      gmt = timeZoneHome.replaceAll(r'plus', '+');
    });
  }

  Future reloadTZ(Timer time) async {
    time = await Timer(Duration(milliseconds: 2000), parseTZ);
  }

  @override
  void initState() {
    super.initState();
    HomeLayout.zonetimeLive = 'GMTplus7';
  }

  @override
  Widget build(BuildContext context) {
    reloadTZ(time);
    return Scaffold(
      key: _drawer,
      drawer: Opacity(
        opacity: 0.9,
        child: Drawer(
          elevation: 10.0,
          child: DrawerComp(),
        ),
      ),
      endDrawer: Opacity(
        opacity: 0.9,
        child: Drawer(
          elevation: 10.0,
          child: DrawerTimeZone(locations: timeZoneHome),
        ),
      ),
      body: new Stack(
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
                  title: Center(child: gmt == null ? Text('Live Score : GMT+7',style: TextStyle(fontSize: 14.0)) : Text('Live Score : ${gmt}',style: TextStyle(fontSize: 14.0))),
                  actions: <Widget>[
                    new IconButton(
                      icon: Icon(Icons.av_timer),
                      onPressed: () => _drawer.currentState.openEndDrawer(),
                    )
                  ],
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    icon: Icon(Icons.sort),
                    onPressed: () {
                      _drawer.currentState.openDrawer();
                    },
                  ),
                ),
              ),
              Container(height: 600.0, child: LiveMatch(timezoneLive: HomeLayout.zonetimeLive, page: 0)),
            ],
          ),
        ],
      ),
    );
  }
}
