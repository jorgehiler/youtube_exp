import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_exp/providers/search_youtube.provider.dart';
import 'package:youtube_exp/providers/video_youtube.provider.dart';
import 'package:youtube_exp/services/api_youtube.dart';

class VideoSearch extends SearchDelegate<String> {
  VideoSearch() : super(searchFieldLabel: 'Buscar');

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
          child: Text(
        "Este botoncito aun no funciona",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 30),
      )),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var searchProvider =
        Provider.of<SearchYoutubeProvider>(context, listen: false);
    var videoYoutubeProvider =
        Provider.of<VideoYoutubeProvider>(context, listen: false);

    return FutureBuilder(
        future: APIService.instance.fetchSuggestion(query),
        builder: (context, snapshot) {
          List<dynamic> suggestions;
          if (snapshot.data == null) {
            return Container();
          } else {
            suggestions = snapshot.data;
            suggestions.insert(0, query);
            return ListView.builder(
                itemBuilder: (context, index) => ListTile(
                      leading: Icon(Icons.search),
                      title: Text(suggestions[index]),
                      onTap: () {
                        query = suggestions[index];
                        searchProvider.setTextSearch(query);
                        close(context, null);
                        showResults(context);
                      },
                    ),
                itemCount: suggestions.length);
          }
        });
  }
}
