import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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

  @override
  Widget build(BuildContext context) {
    final search = Provider.of<SearchYoutubeProvider>(context);
    final videoYoutubeProvider = Provider.of<VideoYoutubeProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Buscar'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
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
                                padding:
                                    const EdgeInsets.only(left: 5.0, right: 5),
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
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      SizedBox(height: 4),
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(videoYoutubeProvider
                                              .getVideo()
                                              .publishTime)),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                height: 10,
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
                                          child: Text(videoYoutubeProvider
                                              .getDescription())),
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
