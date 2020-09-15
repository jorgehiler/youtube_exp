import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_exp/providers/search_youtube.provider.dart';
import 'package:youtube_exp/video_%20carousel.dart';
import 'package:youtube_exp/video_screen.dart';
import 'package:youtube_exp/video_search.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SearchYoutubeProvider(),
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
            child: Container(
          child: ListView(
            padding: EdgeInsets.only(left: 20, right: 20),
            children: [
              Container(height: 120, child: Carousel()),
              Container(
                child: VideoScreen(id: 'feQhHStBVLE'),
                height: 200,
              ),
            ],
          ),
        )));
  }
}
