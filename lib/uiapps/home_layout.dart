import 'package:flutter/material.dart';
import 'package:livescore/materialui/cardview.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeLayout extends StatefulWidget {
  static final String tag = "/MAIN_LAYOUT";
  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    title: Center(child: new Text('Live Score')),
                    actions: <Widget>[
                      new IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          print('search leading');
                        },
                      )
                    ],
                    backgroundColor: Colors.transparent,
                    leading: IconButton(
                      icon: Icon(Icons.sort),
                      onPressed: () {
                        print('Icon Leading');
                      },
                    ),
                  ),
                ),
                new Container(
                  height: 500.0,
                  padding: EdgeInsets.all(10.0),
                  child: LiveMatch(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
