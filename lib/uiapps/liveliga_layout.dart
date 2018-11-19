import 'package:flutter/material.dart';
import 'package:livescore/materialui/cardview.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LigaLayout extends StatefulWidget {
  @override
  _LigaLayoutState createState() => _LigaLayoutState();
}

class _LigaLayoutState extends State<LigaLayout> {
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
                    title: Center(child: new Text('Live Liga')),
                    actions: <Widget>[
                      new IconButton(
                        icon: Icon(Icons.info_outline),
                        onPressed: () {
                          print('search leading');
                        },
                      )
                    ],
                    backgroundColor: Colors.transparent,
                  ),
                ),
                new Container(
                  height: 600.0,
                  padding: EdgeInsets.all(10.0),
                  child: LigaMatch(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}