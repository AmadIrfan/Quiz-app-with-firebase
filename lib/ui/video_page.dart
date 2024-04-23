import 'package:flutter/material.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../resizer/widget_utils.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key, required this.url, required this.name});
  final String url;
  final String name;
  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    try {
      String? videoId = YoutubePlayer.convertUrlToId(widget.url);
      _controller = YoutubePlayerController(
        initialVideoId: videoId!,
        flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: true,
        ),
      );
    } catch (e) {
      showCustomToast(
        context: context,
        message: e.toString(),
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Hero(
            tag: widget.url,
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              aspectRatio: 16 / 9,
            ),
          ),
        ),
      ),
    );
  }
}
