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
  String tz = 'GMTplus9';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawer,
      drawer: Opacity(
        opacity: 0.9,
        child: Drawer(
          elevation: 10.0,
          child: DrawerComp(),
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
                  actions: <Widget>[
                    new IconButton(
                      icon: Icon(Icons.info_outline),
                      onPressed: () {
                        showDialog(
                          context: context,
                          child: AlertDialog(
                            title: new Text('About Us'),
                            content: Container(
                              height: 200.0,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Text(
                                        '== Crawling Team A2Z Solusindo =='),
                                  ),
                                  new Text('Dezza'),
                                  new Text('Exan'),
                                  new Text('Ridwan'),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Text('== Peace =='),
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: new Text('Close'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    icon: Icon(Icons.sort),
                    onPressed: () => _drawer.currentState.openDrawer(),
                  ),
                ),
              ),
              Container(
                height: 500.0,
                child: LiveMatch(timezone: tz)),
            ],
          ),
        ],
      ),
    );
  }
}
