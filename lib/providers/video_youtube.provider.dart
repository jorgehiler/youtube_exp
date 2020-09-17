import 'package:flutter/cupertino.dart';
import 'package:youtube_exp/models/video.model.dart';
import 'package:youtube_exp/services/api_youtube.dart';

class VideoYoutubeProvider with ChangeNotifier {
  Video _currentVideo;
  String _idVideo = "uLw3FicM6AM"; //Borrar este
  String _description = "";

  updateScreen(Video video) {
    print("Actualizando video en reproducción");
    print(_idVideo);
    this._currentVideo = video;
    this._idVideo = _currentVideo.id;
    this._getDescription(video.id).then((value) {
      this._description = value;
      notifyListeners();
    });
    //Temporal
    // this._description =
    //     'La ciática es un conjunto de síntomas que incluyen dolor causado por la compresión general o irritación de una de las cinco raíces de los nervios espinales de cada nervio ciático o por compresión o irritación de los nervios izquierda o derecha o ambos ciáticos. Los síntomas incluyen dolor de espalda, dolor en la nalga y dolor, entumecimiento o debilidad en diferentes partes de la pierna y el pie. Otros síntomas incluyen un "alfileres y agujas" sensibilidad o sensación de hormigueo y dificultad para mover o controlar la pierna. Típicamente, los síntomas se manifiestan sólo en un lado del cuerpo. El dolor puede irradiarse por debajo de la rodilla, pero no siempre. La ciática es un conjunto de síntomas que incluyen dolor causado por la compresión general o irritación de una de las cinco raíces de los nervios espinales de cada nervio ciático o por compresión o irritación de los nervios izquierda o derecha o ambos ciáticos. Los síntomas incluyen dolor de espalda, dolor en la nalga y dolor, entumecimiento o debilidad en diferentes partes de la pierna y el pie. Otros síntomas incluyen un "alfileres y agujas" sensibilidad o sensación de hormigueo y dificultad para mover o controlar la pierna. Típicamente, los síntomas se manifiestan sólo en un lado del cuerpo. El dolor puede irradiarse por debajo de la rodilla, pero no siempre';
    // notifyListeners();
  }

  String getIdVideo() {
    return _idVideo;
  }

  Future<String> _getDescription(String id) async {
    String description = await APIService.instance.fetchDescriptionComplete(id);
    print('Complete description');
    print(description);
    return description;
  }

  Video getVideo() {
    return this._currentVideo;
  }

  String getDescription() {
    print(_description);
    return this._description;
  }

  constructor() {}
}
