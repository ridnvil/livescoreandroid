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
    playerController = VideoPlayerController.network(this.widget.urlVideo)
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
