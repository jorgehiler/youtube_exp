import 'package:flutter/cupertino.dart';
import 'package:youtube_exp/models/video.model.dart';
import 'package:youtube_exp/services/api_youtube.dart';

class VideoYoutubeProvider with ChangeNotifier {
  Video _currentVideo;
  String _idVideo = "uLw3FicM6AM"; //Borrar este
  String _description = "";

  updateScreen(Video video) {
    this._currentVideo = video;
    this._idVideo = _currentVideo.id;
    this._getDescription(video.id).then((value) {
      this._description = value;
      notifyListeners();
    });
  }

  String getIdVideo() {
    return _idVideo;
  }

  Future<String> _getDescription(String id) async {
    String description = await APIService.instance.fetchDescriptionComplete(id);
    return description;
  }

  Video getVideo() {
    return this._currentVideo;
  }

  String getDescription() {
    return this._description;
  }

  constructor() {}
}
