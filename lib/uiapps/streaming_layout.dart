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

  const LiveStreaming(
      {Key key,
      this.matchlive,
      this.home,
      this.away,
      this.score,
      this.time,
      this.halftime,
      this.status})
      : super(key: key);

  @override
  _LiveStreamingState createState() => _LiveStreamingState();
}

class _LiveStreamingState extends State<LiveStreaming> {
  String url = 'https://r1---sn-vgqsrn76.googlevideo.com/videoplayback?itag=22&ip=54.80.113.186&mm=31%2C26&ipbits=0&ratebypass=yes&dur=429.383&id=o-ADBgT193BEYePc6BUJDlmlsB008AIJzObNqCRw-mFo09&pl=14&lmt=1540004638933789&ms=au%2Conr&mv=m&mt=1542876943&txp=5531432&key=yt6&source=youtube&mime=video%2Fmp4&ei=fm_2W92wL4eJgwOona-gBg&expire=1542898654&c=WEB&requiressl=yes&sparams=dur%2Cei%2Cid%2Cinitcwndbps%2Cip%2Cipbits%2Citag%2Clmt%2Cmime%2Cmm%2Cmn%2Cms%2Cmv%2Cpl%2Cratebypass%2Crequiressl%2Csource%2Cexpire&signature=7FDE9B66B939D937975004F25CDF1062D465F131.445ED335FC1B3E7881FBF0442C4CD364B72A56F9&fvip=1&mn=sn-vgqsrn76%2Csn-tt1e7n7k&initcwndbps=2078750';

  @override
  Widget build(BuildContext context) {
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
