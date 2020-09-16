import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_exp/providers/search_youtube.provider.dart';
import 'package:youtube_exp/providers/video_youtube.provider.dart';
import 'package:youtube_exp/services/api_youtube.dart';

import 'models/video.model.dart';

class Carousel extends StatelessWidget {
  final List videos = [
    new Video(
        id: 'KzTeWPkUxQs',
        title: 'Flutter Presentación en Español',
        shortDescription:
            'Martin Aguinis presenta sobre Flutter en Español durante México Partner Day. Flutter es el kit UI portátil de Google para crear aplicaciones nativas para móvil, ...',
        thumbnailUrl: "https://i.ytimg.com/vi/KzTeWPkUxQs/default.jpg",
        channelTitle: 'Flutter',
        publishTime: '2019-07-04T01:13:37Z'),
    new Video(
        id: 'KzTeWPkUxQs',
        title: 'Flutter Presentación en Español',
        shortDescription:
            'Martin Aguinis presenta sobre Flutter en Español durante México Partner Day. Flutter es el kit UI portátil de Google para crear aplicaciones nativas para móvil, ...',
        thumbnailUrl: "https://i.ytimg.com/vi/cILHRB8Syng/default.jpg",
        channelTitle: 'Flutter',
        publishTime: '2019-07-04T01:13:37Z'),
    new Video(
        id: 'KzTeWPkUxQs',
        title: 'Flutter Presentación en Español',
        shortDescription:
            'Martin Aguinis presenta sobre Flutter en Español durante México Partner Day. Flutter es el kit UI portátil de Google para crear aplicaciones nativas para móvil, ...',
        thumbnailUrl: "https://i.ytimg.com/vi/I9ceqw5Ny-4/default.jpg",
        channelTitle: 'Flutter',
        publishTime: '2019-07-04T01:13:37Z'),
    new Video(
        id: 'KzTeWPkUxQs',
        title: 'Flutter Presentación en Español',
        shortDescription:
            'Martin Aguinis presenta sobre Flutter en Español durante México Partner Day. Flutter es el kit UI portátil de Google para crear aplicaciones nativas para móvil, ...',
        thumbnailUrl: "https://i.ytimg.com/vi/I9ceqw5Ny-4/default.jpg",
        channelTitle: 'Flutter',
        publishTime: '2019-07-04T01:13:37Z')
  ];

  @override
  Widget build(BuildContext context) {
    var youtubeProvider = Provider.of<SearchYoutubeProvider>(context);
    Future<List<Video>> homeCards =
        APIService.instance.fetchSearch(textSearch: youtubeProvider.textSearch);
    return FutureBuilder<List<Video>>(
      future: homeCards,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(10.0),
                  children: snapshot.data.map<Widget>((img) {
                    return _VideoItem(video: img); //Feature(photo);
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
            //ONTAP

            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: InkWell(
              onTap: () {
                videoYoutubeProvider.updateScreen(video.id);
              },
              child: Stack(
                children: <Widget>[
                  Image.network(video.thumbnailUrl,
                      width: 120, height: 90, fit: BoxFit.cover),
                ],
              ),
            ),
          ),
        ]);
  }
}
