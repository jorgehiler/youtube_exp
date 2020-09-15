import 'package:flutter/material.dart';

class VideoSearch extends SearchDelegate<String> {
  final suggestions = ["Casa grande", "Casa pequeña", "Casa mediana"];
  final recent = ["Mi casa", "Mi garaje"];

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
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty ? recent : suggestions;

    return ListView.builder(
        itemBuilder: (context, index) => ListTile(
              leading: Icon(Icons.search),
              title: Text(suggestionList[index]),
            ),
        itemCount: suggestionList.length);
  }
}
