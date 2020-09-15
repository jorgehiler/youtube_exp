import 'package:flutter/material.dart';
import 'package:youtube_exp/models/video_model.dart';
import 'package:youtube_exp/services/api_youtube.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;
  List<Video> _video;

   @override
  void initState() {
    super.initState();
    _initChannel();
  }

  _initChannel() async {
    List<Video> video = await APIService.instance
        .fetchSearch(textSearch: 'casa');
    setState(() {
      _video = video;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _video.forEach((Video element) {print(element.title);
      print(element.id);
      print(element.channelTitle);
      print(element.publishTime);
      print(element.thumbnailUrl);
      print(element.shortDescription);
      print(element.title);});
    });
  }

  Future<void> dummy() async {
     var channel = await APIService.instance
        .fetchSearch(textSearch: 'casa');
        print(channel);    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), 
    );
  }
}
