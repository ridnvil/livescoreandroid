import 'dart:async';

import 'package:flutter/material.dart';
import 'package:livescore/uiapps/livestreaming_layout.dart';

class LiveStreaming extends StatefulWidget {
  final String matchlive;
  final String home;
  final String away;
  final String score;
  final String time;
  final String halftime;
  final String status;
  final String url;
  final String id;

  const LiveStreaming(
      {Key key,
      this.id,
      this.matchlive,
      this.home,
      this.away,
      this.score,
      this.time,
      this.halftime,
      this.status,
      this.url})
      : super(key: key);

  @override
  _LiveStreamingState createState() => _LiveStreamingState();
}

class _LiveStreamingState extends State<LiveStreaming> {
  String urlContent = '';
  String url;

  String score;
  String id;
  String status;

  Timer time;

  Future streamData() async {
    url = this.widget.url;
    setState(() {    
      score = this.widget.score;
      status = this.widget.status;
      id = this.widget.id;
    });
    print(url);
  }

  Future data(Timer time) async {
    time = Timer(Duration(milliseconds: 5000), streamData);
  }

  @override
    void initState() {
      super.initState();
      data(time);
    }

  @override
  Widget build(BuildContext context) {
    data(time);
    return Scaffold(
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
              AppBar(
                title: Center(child: new Text(widget.matchlive)),
                actions: <Widget>[
                  new IconButton(
                    icon: Icon(Icons.info_outline),
                    onPressed: () {
                      showDialog(
                        context: context,
                        child: AlertDialog(
                          title:
                              new Text('About Us', textAlign: TextAlign.center),
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
              new Container(
                padding: EdgeInsets.all(5.0),
                color: Colors.black38,
                height: 150.0,
                child: new Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.home,
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("${widget.status}",
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center),
                              )),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(widget.score,
                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    child: Image.asset('assets/live.jpg'),
                                    onTap: () {
                                      print('Live');
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Streaming(
                                                    urlVideo:url)));
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.away,
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
