import 'package:flutter/cupertino.dart';
import 'package:youtube_exp/models/video.model.dart';

class VideoYoutubeProvider with ChangeNotifier {
  Video currentVideo;
  String _idVideo = "uLw3FicM6AM";

  updateScreen(String idVideo) {
    print("Actualizando video en reproducción");
    print(idVideo);
    this._idVideo = idVideo;
    notifyListeners();
  }

  get idVideo => _idVideo;

  getIdVideo() {
    return _idVideo;
  }

  constructor() {}
}
