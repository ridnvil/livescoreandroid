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
  final String url =
      "http://192.168.2.111/azsolusindo/public/api/matchSchedule?Post_Param_Data=0";

  Timer time;
  Map status;
  Map message;
  Map num_row;
  Map data;
  List datalist;

  Future<List> getDataLive() async {
    http.Response response = await http.get(url);
    if (response.persistentConnection == true) {
      data = json.decode(response.body);
      setState(() {
        datalist = data["data"];
      });
    } else {
      print('Connection Error');
    }
  }

  @override
  void initState() {
    super.initState();
    //getDataLive();
  }

  @override
  Widget build(BuildContext context) {
    getDataLive();
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
  final String url = "http://192.168.2.111/azsolusindo/public/api/matchResult";
  Timer time;
  Map status;
  Map message;
  Map num_row;
  Map data;
  List datalist;

  Future<List> getDataResult() async {
    http.Response response = await http.get(url);
    if (response.persistentConnection == true) {
      data = json.decode(response.body);
      setState(() {
        datalist = data["data"];
      });
    } else {
      print('Connection Error');
    }
  }

  @override
  void initState() {
    super.initState();
    getDataResult();
  }

  @override
  Widget build(BuildContext context) {
    getDataResult();
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
  final String url =
      "http://192.168.2.111/phprest/api/match/matchLivePerLig.php";

  Map status;
  Map message;
  Map num_row;
  Map data;
  Map liga;
  List<String> match;
  String dataliga;
  String ligname;
  var listname;

  Future<List> getDataLiveLiga() async {
    http.Response response = await http.get(url);
    data = json.decode(response.body);
    setState(() {
      liga = data["data"];
      listname = liga.keys;
    });
    print(listname.toString());
    //return data["data"];
  }

  @override
  void initState() {
    super.initState();
    getDataLiveLiga();
  }

  @override
  Widget build(BuildContext context) {
    getDataLiveLiga();
    return Container(child: new Text('${listname}'));
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
      width: 200.0,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FlatButton(
                padding: EdgeInsets.only(right: 0.0),
                child: Container(
                  padding: EdgeInsets.only(
                      top: 5.0, bottom: 5.0, left: 10.0, right: 90.0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Icon(Icons.play_circle_outline,
                            color: Colors.red),
                      ),
                      new Text('Live Match',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Divider(
                color: Colors.white,
              ),
              FlatButton(
                padding: EdgeInsets.only(right: 0.0),
                child: Container(
                    padding: EdgeInsets.only(
                        top: 5.0, bottom: 5.0, left: 10.0, right: 90.0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Icon(Icons.menu, color: Colors.white),
                        ),
                        new Text('Result',
                            style: TextStyle(color: Colors.white)),
                      ],
                    )),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ResultLayout()));
                },
              ),
              Divider(
                color: Colors.white,
              ),
              FlatButton(
                padding: EdgeInsets.only(right: 0.0),
                child: Container(
                  padding: EdgeInsets.only(
                      top: 5.0, bottom: 5.0, left: 10.0, right: 90.0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Icon(Icons.play_circle_filled, color: Colors.white),
                      ),
                      new Text('Live Liga',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
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
