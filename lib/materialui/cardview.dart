import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class LiveMatch extends StatefulWidget {
  LiveMatch({Key key}) : super(key: key);
  @override
  _LiveMatchState createState() => _LiveMatchState();
}

class _LiveMatchState extends State<LiveMatch> {

  Map status;
  Map message;
  Map num_row;
  Map data;
  List dataList;

  Future getDataLive() async {
    http.Response response =
        await http.get("http://192.168.2.111/phprest/api/match/matchLive.php");
    data = json.decode(response.body);
    setState(() {
      dataList = data["data"];
    });
    debugPrint(dataList.toString());
  }

  @override
  void initState() {
    super.initState();
    getDataLive();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: dataList == null ? 0 : dataList.length,
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
                        Expanded(child: Text(dataList[index]["time"],style: TextStyle(color: Colors.white))),
                        Text("Half Time : ${dataList[index]["ht"]}",style: TextStyle(color: Colors.white)),
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
                            new Text(dataList[index]["contest"],style: TextStyle(color: Colors.white)),
                            new Text(dataList[index]["status"],style: TextStyle(color: Colors.white))
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(dataList[index]["home"],style: TextStyle(color: Colors.white)),
                            new Text(dataList[index]["score"],style: TextStyle(color: Colors.white)),
                            new Text(dataList[index]["away"],style: TextStyle(color: Colors.white))
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
    );
  }
}
