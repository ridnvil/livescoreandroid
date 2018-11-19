import 'package:flutter/material.dart';
import 'package:livescore/materialui/cardview.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ResultLayout extends StatefulWidget {
  @override
  _ResultLayoutState createState() => _ResultLayoutState();
}

class _ResultLayoutState extends State<ResultLayout> {
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
                    title: Center(child: new Text('Result Match')),
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
                  ),
                ),
                new Container(
                  height: 600.0,
                  padding: EdgeInsets.all(10.0),
                  child: ResultMatch(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
