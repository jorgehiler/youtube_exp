import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_exp/providers/search_youtube.provider.dart';
import 'package:youtube_exp/providers/video_youtube.provider.dart';
import 'models/video.model.dart';

class Carousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final searchYoutubeProvider =
        Provider.of<SearchYoutubeProvider>(context, listen: false);
    final videoYoutubeProvider =
        Provider.of<VideoYoutubeProvider>(context, listen: false);

    Future<List<Video>> homeCards = searchYoutubeProvider.search(
        searchYoutubeProvider.textSearch, videoYoutubeProvider);
    return FutureBuilder<List<Video>>(
      future: homeCards,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          videoYoutubeProvider.updateScreen(snapshot.data[0]);
          return Container(
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(10.0),
                  children: snapshot.data.map<Widget>((img) {
                    return _VideoItem(video: img);
                  }).toList()));
        } else {
          return Container(
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(10.0),
                  children: <Widget>[
                Container(
                  height: 90,
                  width: 120,
                ),
                Container(
                  height: 90,
                  width: 120,
                ),
                Container(
                  height: 90,
                  width: 120,
                ),
                Container(
                  height: 90,
                  width: 120,
                )
              ]));
        }
      },
    );
  }
}

class _VideoItem extends StatelessWidget {
  _VideoItem({Key key, @required this.video}) : super(key: key);

  final Video video;
  @override
  Widget build(BuildContext context) {
    final videoYoutubeProvider =
        Provider.of<VideoYoutubeProvider>(context, listen: false);

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: InkWell(
              onTap: () {
                videoYoutubeProvider.updateScreen(video);
              },
              child: Stack(
                children: <Widget>[
                  FadeInImage(
                      placeholder: AssetImage('assets/img/loading.png'),
                      image: NetworkImage(
                        video.thumbnailUrl,
                      ),
                      width: 120,
                      height: 90,
                      fit: BoxFit.cover),
                ],
              ),
            ),
          ),
        ]);
  }
}
