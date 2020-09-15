import 'package:flutter/material.dart';
import 'package:youtube_exp/services/api_youtube.dart';

class VideoSearch extends SearchDelegate<String> {
  final suggestions = ["Casa grande", "Casa pequeña", "Casa mediana"];
  final recent = ["Mi casa", "Mi garaje"];

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
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //final suggestionList = query.isEmpty ? recent : suggestions;
    return FutureBuilder(
        future: APIService.instance.fetchSuggestion(query),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container();
          } else {
            return ListView.builder(
                itemBuilder: (context, index) => ListTile(
                      leading: Icon(Icons.search),
                      title: Text(snapshot.data[index]),
                      onTap: () {
                        query = snapshot.data[index];
                        close(context, null);
                        showResults(context);
                      },
                    ),
                itemCount: snapshot.data.length);
          }
        });
  }
}