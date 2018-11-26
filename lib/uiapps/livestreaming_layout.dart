import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:rxdart/rxdart.dart';
import 'package:connectivity/connectivity.dart';

Future<List<Post>> fetchData(http.Client client) async {
  final response = await client.get('http://azsolusindo.info/azsolusindo/public/api/matchAndroidSchedule/GMTplus7/0/null/null');
  return compute(parseData, response.body);
}

List<Post> parseData(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Post>((json)=>Post.fromJson(json)).toList();
}

class Post{
  final List data;
  final String id;
  final String contest;
  final String time;
  final int status;
  final String home;
  final String score;
  final String away;
  final String ht;
  final String source;

  Post({this.data,this.id,this.contest,this.time,this.status,this.home,this.score,this.away,this.ht,this.source});

  factory Post.fromJson(Map<String, dynamic> json){
    return Post(
      data: json["data"],
      id: json["id"],
      contest: json["contest"],
      time: json["time"],
      status: json["status"],
      home: json["home"],
      score: json["score"],
      away: json["away"],
      ht: json["ht"],
      source: json["source"]
    );
  }
}

class Streaming extends StatefulWidget {
  final List<Post> dataCard;

  const Streaming({Key key, this.dataCard}) : super(key: key);
  @override
  _StreamingState createState() => _StreamingState();
}

class _StreamingState extends State<Streaming> {  
  Map dt;
  StreamSubscription connectivity;
  bool boolHasConnection;

  Stream<List> getData() async* {
    
    setState(() {
        
    });
  }

  Future<Null> getConnectionStatus() async {
    connectivity = new Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      debugPrint(result.toString());
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        setState(() {
          boolHasConnection = true;
        });
      } else {
        setState(() {
          boolHasConnection = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getConnectionStatus();
  }

  @override
    void dispose() {
      super.dispose();
      try {
        connectivity?.cancel();
      } catch (exception, stackTrace) {
        print(exception.toString());
      }finally{
        super.dispose();
        getData();
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new StreamBuilder(
        stream: getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return new Container(
                  child: Center(child: new Text('Data Not Found..')));
            case ConnectionState.waiting:
              return new Container(child: Center(child: new CircularProgressIndicator()));
            default:
              if (snapshot.hasError) {
                return new Container(
                    child: Center(
                        child: new Text(snapshot.data.boolHasConnection.toString())));
              } else {
                return new Container(
                    child: Center(
                        child: new Text(boolHasConnection.toString())));
              }
          }
        },
      ),
    );
  }
}
