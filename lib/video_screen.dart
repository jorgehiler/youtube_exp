import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_exp/providers/video_youtube.provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  final String id;

  VideoScreen({Key key, this.id}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final videoYoutubeProvider = Provider.of<VideoYoutubeProvider>(context);

    print('Desde el build nuevo id ${videoYoutubeProvider.getIdVideo()}');
    print('Pasado por parametro ${widget.id}');
    return YoutubePlayer(
      controller: YoutubePlayerController(
        initialVideoId: widget.id,
        flags: YoutubePlayerFlags(
          mute: false,
          autoPlay: false,
        ),
      ),
      showVideoProgressIndicator: true,
      onReady: () {
        print('Player is ready.');
      },
    );
  }
}
