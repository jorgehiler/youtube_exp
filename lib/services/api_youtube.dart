import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:youtube_exp/models/video.model.dart';
import 'package:youtube_exp/utilities/api_key.dart';

class APIService {
  APIService._instantiate();

  static final APIService instance = APIService._instantiate();

  final String _baseUrl = 'www.googleapis.com';

  Future<List<Video>> fetchSearch({String textSearch}) async {
    Map<String, String> parameters = {
      'part': 'id, snippet',
      'q': textSearch,
      'key': API_KEY,
      'type': 'video',
      'maxResults': '6'
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/search',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<dynamic> videosJson = data['items'];
      List<Video> videos = [];
      videosJson.forEach(
        (json) => videos.add(
          Video.fromMap(json),
        ),
      );
      return videos;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future fetchSuggestion(String q) async {
    const baseUrl =
        'http://suggestqueries.google.com/complete/search?client=firefox&ds=yt&q=';
    var response = await http.get(baseUrl + q);
    print(response.statusCode);
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      List<dynamic> suggestions = data[1];
      return suggestions;
    }
    return [];
  }

  //Poner bonita url
  Future<String> fetchDescriptionComplete(String id) async {
    var bUrl =
        'https://www.googleapis.com/youtube/v3/videos?part=snippet&id=$id&fields=items/snippet/title,items/snippet/description&key=$API_KEY';
    var response = await http.get(bUrl);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print('data');
      print(data);
      String description = data['items'][0]['snippet']['description'];
      return description;
    }
    return '';
  }

  Future<List<Video>> fetchSearchFake({String textSearch}) async {
    var completer = new Completer<List<Video>>();
    // At some time you need to complete the future:

    List<Video> videos = [
      new Video(
          id: 'KzTeWPkUxQs',
          title:
              'Flutter Presentación en Español largo largo largo largo largo largo, largo, largo ,arggd ,a , largo, largo, largo',
          shortDescription:
              'Martin Aguinis presenta sobre Flutter en Español durante México Partner Day. Flutter es el kit UI portátil de Google para crear aplicaciones nativas para móvil, ...',
          thumbnailUrl: "https://i.ytimg.com/vi/KzTeWPkUxQs/default.jpg",
          channelTitle: 'Flutter',
          publishTime: '2019-07-04'),
      new Video(
          id: 'L3c66Ve20EU',
          title: 'Flutter Presentación en Español',
          shortDescription:
              'Martin Aguinis presenta sobre Flutter en Español durante México Partner Day. Flutter es el kit UI portátil de Google para crear aplicaciones nativas para móvil, ...',
          thumbnailUrl: "https://i.ytimg.com/vi/cILHRB8Syng/default.jpg",
          channelTitle: 'Flutter',
          publishTime: '2019-07-04'),
      new Video(
          id: '5Vq-oJEj9Qk',
          title: 'Flutter Presentación en Español',
          shortDescription:
              'Martin Aguinis presenta sobre Flutter en Español durante México Partner Day. Flutter es el kit UI portátil de Google para crear aplicaciones nativas para móvil, ...',
          thumbnailUrl: "https://i.ytimg.com/vi/I9ceqw5Ny-4/default.jpg",
          channelTitle: 'Flutter',
          publishTime: '2019-07-04'),
      new Video(
          id: 'I6ypD7qv3Z8',
          title: 'Flutter Presentación en Español',
          shortDescription:
              'Martin Aguinis presenta sobre Flutter en Español durante México Partner Day. Flutter es el kit UI portátil de Google para crear aplicaciones nativas para móvil, ...',
          thumbnailUrl: "https://i.ytimg.com/vi/I9ceqw5Ny-4/default.jpg",
          channelTitle: 'Flutter',
          publishTime: '2019-07-04')
    ];
    completer.complete(videos);

    return completer.future;
  }
}
