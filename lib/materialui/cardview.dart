import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:livescore/uiapps/home_layout.dart';
import 'package:livescore/uiapps/liveliga_layout.dart';
import 'package:livescore/uiapps/result_layout.dart';

class LiveMatch extends StatefulWidget {
  LiveMatch({Key key}) : super(key: key);
  @override
  _LiveMatchState createState() => _LiveMatchState();
}

class _LiveMatchState extends State<LiveMatch> {
  final String url = "http://192.168.2.111/phprest/api/match/matchLive.php";
  StreamController streamController = StreamController();
  Timer time;
  Map status;
  Map message;
  Map num_row;
  Map data;
  List datalist;
  Stream<List> stream;

  Future<List> getDataLive() async {
    http.Response response = await http.get(url);
    data = json.decode(response.body);
    setState(() {
      datalist = data["data"];
    });
    return data["data"];
  }

  @override
  void initState() {
    super.initState();
    getDataLive();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        onRefresh: getDataLive,
        child: new ListView.builder(
          itemCount: datalist == null ? 0 : datalist.length,
          itemBuilder: (BuildContext context, int index) {
            return new Card(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5.0),
                      color: Colors.white12,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Text(datalist[index]["time"],
                                  style: TextStyle(color: Colors.white))),
                          Text("Half Time : ${datalist[index]["ht"]}",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(right: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(datalist[index]["contest"],
                                  style: TextStyle(color: Colors.white)),
                              new Text(datalist[index]["status"],
                                  style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(datalist[index]["home"],
                                  style: TextStyle(color: Colors.white)),
                              new Text(datalist[index]["score"],
                                  style: TextStyle(color: Colors.white)),
                              new Text(datalist[index]["away"],
                                  style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ResultMatch extends StatefulWidget {
  @override
  _ResultMatchState createState() => _ResultMatchState();
}

class _ResultMatchState extends State<ResultMatch> {
  final String url = "http://192.168.2.111/phprest/api/match/matchResult.php";
  StreamController streamController = StreamController();
  Timer time;
  Map status;
  Map message;
  Map num_row;
  Map data;
  List datalist;
  Stream<List> stream;

  Future<List> getDataResult() async {
    http.Response response = await http.get(url);
    data = json.decode(response.body);
    setState(() {
      datalist = data["data"];
    });
    return data["data"];
  }

  @override
  void initState() {
    super.initState();
    getDataResult();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        onRefresh: getDataResult,
        child: new ListView.builder(
          itemCount: datalist == null ? 0 : datalist.length,
          itemBuilder: (BuildContext context, int index) {
            return new Card(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5.0),
                      color: Colors.white12,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Text(datalist[index]["time"],
                                  style: TextStyle(color: Colors.white))),
                          Text("Half Time : ${datalist[index]["ht"]}",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(right: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(datalist[index]["contest"],
                                  style: TextStyle(color: Colors.white)),
                              new Text(datalist[index]["status"],
                                  style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(datalist[index]["home"],
                                  style: TextStyle(color: Colors.white)),
                              new Text(datalist[index]["score"],
                                  style: TextStyle(color: Colors.white)),
                              new Text(datalist[index]["away"],
                                  style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class LigaMatch extends StatefulWidget {
  @override
  _LigaMatchState createState() => _LigaMatchState();
}

class _LigaMatchState extends State<LigaMatch> {
  final String url = "http://192.168.2.111/phprest/api/match/matchLivePerLig.php";
  StreamController streamController = StreamController();
  Timer time;
  Map status;
  Map message;
  Map num_row;
  Map data;
  List datalist;
  List dataliga;
  Stream<List> stream;

  Future<List> getDataLiveLiga() async {
    http.Response response = await http.get(url);
    data = json.decode(response.body);
    setState(() {
      datalist = data[0]["data"];
    });
    print(data[0]["data"]);
    //return data["data"];
  }

  @override
  void initState() {
    super.initState();
    getDataLiveLiga();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}

class DrawerComp extends StatefulWidget {
  @override
  _DrawerCompState createState() => _DrawerCompState();
}

class _DrawerCompState extends State<DrawerComp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end:
              Alignment(0.8, 1.2), // 10% of the width, so there are ten blinds.
          colors: [
            const Color(0xFF0F2027),
            const Color(0xFF061700),
          ], // whitish to gray
          tileMode: TileMode.mirror, // repeats the gradient over the canvas
        ),
      ),
      child: ListView(
        children: <Widget>[
          Divider(
            color: Colors.white,
          ),
          Column(
            children: <Widget>[
              FlatButton(
                child: new Text('Live Match',
                    style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeLayout()));
                },
              ),
              Divider(
                color: Colors.white,
              ),
              FlatButton(
                child:
                    new Text('Result', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ResultLayout()));
                },
              ),
              Divider(
                color: Colors.white,
              ),
              FlatButton(
                child: new Text('Live Liga',
                    style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LigaLayout()));
                },
              ),
              Divider(
                color: Colors.white,
              ),
            ],
          )
        ],
      ),
    );
  }
}
