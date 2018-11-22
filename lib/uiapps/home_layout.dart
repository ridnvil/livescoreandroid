import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:livescore/materialui/cardview.dart';
import 'package:livescore/materialui/timezone.dart';
import 'package:timezone/timezone.dart';
import 'package:timezone/standalone.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

class HomeLayout extends StatefulWidget {
  static final String tag = "/MAIN_LAYOUT";

  const HomeLayout({Key key}) : super(key: key);
  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  GlobalKey<ScaffoldState> _drawer = new GlobalKey<ScaffoldState>();
  List<String> list;
  String timeZone;
  Timer time;

  Future<String> parseTZ() async {
    setState(() {
      timeZone = 'GMTplus6';
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
          child: DrawerTimeZone(),
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
                  title: Center(child: new Text('Live Score')),
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    icon: Icon(Icons.sort),
                    onPressed: () => _drawer.currentState.openDrawer(),
                  ),
                ),
              ),
              Container(height: 512.0, child: LiveMatch(timezone: timeZone)),
            ],
          ),
        ],
      ),
    );
  }
}
