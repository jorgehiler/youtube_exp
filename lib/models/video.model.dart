class Video {
  final String id;
  final String title;
  final String shortDescription;
  final String thumbnailUrl;
  final String channelTitle;
  final String publishTime;

  Video(
      {this.id,
      this.title,
      this.shortDescription,
      this.thumbnailUrl,
      this.channelTitle,
      this.publishTime});

  factory Video.fromMap(Map<String, dynamic> item) {
    Map<String, dynamic> snippet = item['snippet'];
    return Video(
      id: item['id']['videoId'],
      title: snippet['title'],
      shortDescription: snippet['description'],
      thumbnailUrl: snippet['thumbnails']['high']['url'],
      channelTitle: snippet['channelTitle'],
      publishTime: snippet['publishTime'].substring(0, 9),
    );
  }
}
