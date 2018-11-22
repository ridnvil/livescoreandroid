import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:livescore/testroute.dart';
import 'package:livescore/uiapps/home_layout.dart';
import 'package:livescore/uiapps/liveall_layout.dart';
import 'package:livescore/uiapps/liveliga_layout.dart';
import 'package:livescore/uiapps/result_layout.dart';
import 'package:livescore/uiapps/streaming_layout.dart';
import 'package:uri/uri.dart';

class LiveMatch extends StatefulWidget {
  final String timezone;
  const LiveMatch({Key key, @required this.timezone}) : super(key: key);
  @override
  _LiveMatchState createState() => _LiveMatchState();
}

class _LiveMatchState extends State<LiveMatch> {
  //String timezone = 'GMTplus9';
  Timer time;
  Map status;
  Map message;
  Map num_row;
  Map data;
  List datalist;

  Future<List> getDataLive() async {
    String url =
        "http://192.168.2.51/azsolusindo/public/api/matchAndroidSchedule/${this.widget.timezone}/0";
    http.Response response = await http.get(url);
    data = json.decode(response.body);
    setState(() {
      datalist = data["data"];
    });
  }

  Future reloadData(Timer time) async {
    time = Timer(Duration(milliseconds: 15000), getDataLive);
  }

  Future onRefresh() async {
    await getDataLive();
  }

  @override
  void initState() {
    super.initState();
    getDataLive();
  }

  @override
  Widget build(BuildContext context) {
    reloadData(time);
    return Container(
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: new ListView.builder(
          itemCount: datalist == null ? 0 : datalist.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: new Card(
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
                                child: Text('${datalist[index]["time"]}',
                                    style: TextStyle(color: Colors.white))),
                            Expanded(
                              child: Text("LIVE",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 12.0)),
                            ),
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
                                Text(datalist[index]["status"],
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
              ),
              onTap: () {
                print(datalist[index]["contest"]);
                //Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LiveStreaming(
                              matchlive: datalist[index]["contest"],
                              home: datalist[index]["home"],
                              score: datalist[index]["score"],
                              away: datalist[index]["away"],
                              halftime: datalist[index]["ht"],
                              status: datalist[index]["status"],
                            )));
              },
            );
          },
        ),
      ),
    );
  }
}

class AllMatch extends StatefulWidget {
  final String timezone;

  const AllMatch({Key key, this.timezone}):super(key: key);
  @override
  _AllMatchState createState() => _AllMatchState();
}

class _AllMatchState extends State<AllMatch> {
  Timer time;
  Map status;
  Map message;
  Map num_row;
  Map data;
  List datalist;

  Future<List> getAllMatch() async {
    String url =
        "http://192.168.2.51/azsolusindo/public/api/matchAndroidSchedule/${this.widget.timezone}/2";
    http.Response response = await http.get(url);
    data = json.decode(response.body);
    setState(() {
      datalist = data["data"];
    });
  }

  Future reloadData(Timer time) async {
    time = Timer(Duration(milliseconds: 15000), getAllMatch);
  }

  Future onRefresh() async {
    await getAllMatch();
  }

  @override
  void initState() {
    super.initState();
    getAllMatch();
  }

  @override
  Widget build(BuildContext context) {
    reloadData(time);
    return Container(
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: new ListView.builder(
          itemCount: datalist == null ? 0 : datalist.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: new Card(
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
              ),
              onTap: () {

              },
            );
          },
        ),
      ),
    );
  }
}

class ResultMatch extends StatefulWidget {
  final String timezone;

  const ResultMatch({Key key, this.timezone}):super(key:key);
  @override
  _ResultMatchState createState() => _ResultMatchState();
}

class _ResultMatchState extends State<ResultMatch> {
  Timer time;
  Map status;
  Map message;
  Map num_row;
  Map data;
  List datalist;

  Future<List> getDataResult() async {
    String url =
        "http://192.168.2.51/azsolusindo/public/api/matchAndroidSchedule/${this.widget.timezone}/1";
    http.Response response = await http.get(url);
    data = json.decode(response.body);
    setState(() {
      datalist = data["data"];
    });
  }

  Future reloadData(Timer time) async {
    time = Timer(Duration(milliseconds: 15000), getDataResult);
  }

  Future onRefresh() async {
    await getDataResult();
  }

  @override
  void initState() {
    super.initState();
    getDataResult();
  }

  @override
  Widget build(BuildContext context) {
    reloadData(time);
    return Container(
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: new ListView.builder(
          itemCount: datalist == null ? 0 : datalist.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: new Card(
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
              ),
              onTap: (){

              },
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
      "http://azsolusindo.com:8081/phprest/api/match/matchLivePerLig.php";

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
                        child:
                            new Icon(Icons.all_inclusive, color: Colors.white),
                      ),
                      new Text('All Match',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AllMatchLayout()));
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
                        child: new Icon(Icons.info, color: Colors.white),
                      ),
                      new Text('About Us',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    child: AlertDialog(
                      title: new Text('About Us', textAlign: TextAlign.center),
                      content: Container(
                        height: 150.0,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Text(
                                  '== Crawling Team A2Z Solusindo ==',
                                  style: TextStyle(fontSize: 12.0),
                                  textAlign: TextAlign.center),
                            ),
                            new Text('Dezza'),
                            new Text('Exan'),
                            new Text('Ridwan'),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: new Text('== A2Z ==',
                                  style: TextStyle(fontSize: 12.0)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
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

class DrawerTimeZone extends StatefulWidget {
  final String locations;

  const DrawerTimeZone({Key key, this.locations}) : super(key: key);
  @override
  _DrawerTimeZoneState createState() => _DrawerTimeZoneState();
}

class _DrawerTimeZoneState extends State<DrawerTimeZone> {
  Map data;
  List datalist;

  Future<List> getTimezone() async {
    var url =
        "http://192.168.2.51/azsolusindo/public/api/timezoneNameForAndroid";
    http.Response response = await http.get(url);
    data = json.decode(response.body);
    setState(() {
      datalist = data["data"];
    });
    return datalist;
  }

  @override
  void initState() {
    super.initState();
    getTimezone();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
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
      child: ListView.builder(
        itemCount: datalist == null ? 0 : datalist.length,
        itemBuilder: (BuildContext context, int index) {
          return new Column(
            children: <Widget>[
              new Divider(
                color: Colors.white,
              ),
              GestureDetector(
                child: new Text(datalist[index]["Name"],
                    style: TextStyle(color: Colors.white, fontSize: 18.0)),
                onTap: () {
                  Navigator.pop(context);
                  HomeLayout.zonetime = datalist[index]["Name"]
                      .replaceAll(new RegExp(r'\+'), 'plus');
                  //print(bb);
                  ResultLayout.zonetime = datalist[index]["Name"]
                      .replaceAll(new RegExp(r'\+'), 'plus');
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
