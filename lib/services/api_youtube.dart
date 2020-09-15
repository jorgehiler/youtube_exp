import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:youtube_exp/models/video_model.dart';
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
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      List<dynamic> suggestions = data[1];
      return suggestions;
    }
    return [];
  }
}
