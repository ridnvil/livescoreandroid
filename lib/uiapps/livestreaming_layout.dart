import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

class Streaming extends StatefulWidget {
  @override
  _StreamingState createState() => _StreamingState();
}

class _StreamingState extends State<Streaming> {
  //String _youtubeUrl = "https://www.youtube.com/watch?v=obXNwOhKLEI";
  final String url = "https://you-link.herokuapp.com/?url=https://www.youtube.com/watch?v=obXNwOhKLEI";
  VideoPlayerController playerController;
  bool  _isPlaying = false;
  Map urlJson;
  List urlVid;
  List quality;

  Future<String> getVideo() async {
    http.Response response = await http.get(url);
    urlJson = json.decode(response.body);
    setState(() {
      urlVid = urlJson["url"];
      quality = urlJson["quality"]; 
    });
    print(urlJson);
  }

  @override
  void initState() {
    super.initState();
    getVideo();
    
  }

  void createVideo(){
    if(playerController == null){
      playerController = VideoPlayerController.network(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      
    );
  }
}