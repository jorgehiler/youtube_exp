import 'package:flutter/cupertino.dart';
import 'package:youtube_exp/models/video.model.dart';
import 'package:youtube_exp/providers/video_youtube.provider.dart';
import 'package:youtube_exp/services/api_youtube.dart';

class SearchYoutubeProvider with ChangeNotifier {
  String _textSearch = "";
  List<Video> videos = [];
  String _idCurrentlyVideo = "";

  constructor() {}

  //Borrar
  set textSearch(String value) {
    _textSearch = value;
    notifyListeners();
  }

  //Borrar
  setTextSearch(String value) {
    _textSearch = value;
    notifyListeners();
  }

  updateId(String id) {
    _idCurrentlyVideo = id;
    notifyListeners();
  }

  Future<List<Video>> search(
      String value, VideoYoutubeProvider videoYoutubeProvider) async {
    _textSearch = value;
    List<Video> videos =
        await APIService.instance.fetchSearch(textSearch: _textSearch);
    this.videos = videos;
    videoYoutubeProvider.updateScreen(videos[0]);
    return videos;
  }

  String get textSearch => _textSearch;
}
