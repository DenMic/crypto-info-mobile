import 'dart:convert';

class FeedModel {
  final int id;
  final String title;
  final String image;
  final String description;
  final String urlRss;

  FeedModel({this.id, this.title, this.image, this.description, this.urlRss});

  factory FeedModel.fromJson(Map<String, dynamic> json) {
    return FeedModel(
      id: int.parse(json['id']),
      title: json['title'] as String,
      image: json['image'] as String,
      description: json['description'] as String,
      urlRss: json['urlRss'] as String,
    );
  }

  static List<FeedModel> parseListFeedModel(String response) {
    if(response==null){
      return [];
    }
    final parsed = json.decode(response).cast<Map<String, dynamic>>();
    return parsed.map<FeedModel>((jsonString) => new FeedModel.fromJson(jsonString)).toList();
  }
}