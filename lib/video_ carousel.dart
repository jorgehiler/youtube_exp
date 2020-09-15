import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_exp/providers/search_youtube.provider.dart';
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
    return Container(
        child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(10.0),
            children: videos.map<Widget>((img) {
              return _VideoItem(video: img); //Feature(photo);
            }).toList()));
  }
}

class _VideoItem extends StatelessWidget {
  _VideoItem({Key key, @required this.video}) : super(key: key);

  final Video video;
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(
              children: <Widget>[
                Image.network(video.thumbnailUrl,
                    width: 120, height: 90, fit: BoxFit.cover),
              ],
            ),
          ),
        ]);
  }
}
