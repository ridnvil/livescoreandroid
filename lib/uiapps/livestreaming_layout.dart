import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

class Streaming extends StatefulWidget {
  final String urlVideo;

  const Streaming({Key key, this.urlVideo}) : super(key: key);
  @override
  _StreamingState createState() => _StreamingState();
}

class _StreamingState extends State<Streaming> {
  //String _youtubeUrl = "https://www.youtube.com/watch?v=obXNwOhKLEI";
  //var link = "https://you-link.herokuapp.com/?url=https://www.youtube.com/watch?v=obXNwOhKLEI";
  VideoPlayerController playerController;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    playerController = VideoPlayerController.network('https://r1---sn-2a5thxqp5-jb3s.googlevideo.com/videoplayback?signature=24C3F86BE7EB05C13454BD024FD3E20A3D268284.041E614487B1DA9A946E3E69EC819AF09BA84CAF&dur=429.383&fvip=1&ei=aWL5W8OYK8HH8wS1763QDA&gir=yes&sparams=clen,dur,ei,expire,gir,id,ip,ipbits,ipbypass,itag,lmt,mime,mip,mm,mn,ms,mv,pcm2cms,pl,ratebypass,requiressl,source&lmt=1540001023148663&id=o-AJ11nBSmqf1D8R2sZEA2mh9di5C27hsJiDPa-Nu6VpRS&expire=1543091913&ip=54.156.117.75&mime=video%2Fmp4&requiressl=yes&source=youtube&pl=24&itag=18&clen=39453550&c=WEB&key=cms1&txp=5531432&ipbits=0&ratebypass=yes&redirect_counter=1&rm=sn-vgqell7e&fexp=23763603&req_id=b4606ace8693a3ee&cms_redirect=yes&ipbypass=yes&mip=202.80.216.150&mm=31&mn=sn-2a5thxqp5-jb3s&ms=au&mt=1543070262&mv=m&pcm2cms=yes')
      ..addListener(() {
        final bool isPlaying = playerController.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }
      })
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: playerController.value.initialized
            ? AspectRatio(
                aspectRatio: playerController.value.aspectRatio,
                child: VideoPlayer(playerController),
              )
            : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: playerController.value.isPlaying
            ? playerController.pause
            : playerController.play,
        child: Icon(
            playerController.value.isPlaying ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
}
