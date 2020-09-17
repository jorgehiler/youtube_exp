import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:youtube_exp/providers/search_youtube.provider.dart';
import 'package:youtube_exp/providers/video_youtube.provider.dart';
import 'package:youtube_exp/video_%20carousel.dart';
import 'package:youtube_exp/video_screen.dart';
import 'package:youtube_exp/video_search.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => VideoYoutubeProvider()),
        ChangeNotifierProvider(create: (context) => SearchYoutubeProvider())
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Color mainColorLighter = Color.fromRGBO(51, 51, 51, 1);
  final Color mainColorMiddle = Color.fromRGBO(161, 203, 0, 1);
  final Color mainColor = Color.fromRGBO(26, 188, 156, 1);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'youtube-exp',
      theme: ThemeData(
        highlightColor: mainColorMiddle,
        fontFamily: 'Comfortaa',
        appBarTheme: AppBarTheme(color: mainColorMiddle),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Search'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //List<Video> video =await APIService.instance.fetchSearch(textSearch: 'casa');
  final Color mainColorLighter = Color.fromRGBO(51, 51, 51, 1);
  final Color mainColorMiddle = Color.fromRGBO(161, 203, 0, 1);
  final Color mainColor = Color.fromRGBO(26, 188, 156, 1);

  @override
  Widget build(BuildContext context) {
    final search = Provider.of<SearchYoutubeProvider>(context);
    final videoYoutubeProvider = Provider.of<VideoYoutubeProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/img/logo.png',
            fit: BoxFit.cover,
            height: 35,
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                size: 32,
              ),
              onPressed: () {
                showSearch(context: context, delegate: VideoSearch());
              },
            )
          ],
        ),
        body: SafeArea(
            child: Column(
          children: <Widget>[
            Expanded(
                child: Container(
              child: Column(
                children: [
                  Container(height: 120, child: Carousel()),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Consumer<VideoYoutubeProvider>(
                        builder: (_, videoYoutubeProvider, __) => Container(
                          child: Column(
                            children: <Widget>[
                              VideoScreen(
                                id: videoYoutubeProvider.getIdVideo(),
                                key: UniqueKey(),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 9.0, right: 5, top: 10),
                                child: Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            videoYoutubeProvider
                                                .getVideo()
                                                .title,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: mainColorLighter,
                                                fontSize: 18.0,
                                                fontFamily: 'Comfortaa',
                                                fontWeight: FontWeight.w600)),
                                      ),
                                      SizedBox(height: 6),
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            videoYoutubeProvider
                                                .getVideo()
                                                .publishTime,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14.0,
                                                fontFamily: 'Comfortaa',
                                                fontWeight: FontWeight.w400),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                height: 20,
                                thickness: 0.7,
                                color: Colors.grey,
                                indent: 5,
                                endIndent: 5,
                              ),
                              Expanded(
                                child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 5.0,
                                        right: 5.0,
                                        top: 2,
                                        bottom: 5),
                                    child: Scrollbar(
                                      child: SingleChildScrollView(
                                          padding: EdgeInsets.only(right: 20),
                                          child: Text(
                                            videoYoutubeProvider
                                                .getDescription(),
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w300),
                                          )),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ))
          ],
        )));
  }
}
