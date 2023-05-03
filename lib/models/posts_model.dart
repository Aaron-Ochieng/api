// ignore_for_file: non_constant_identifier_names

import 'user_model.dart';

class PostModel {
  int id;
  String body;
  String? image_url;
  DateTime updated_at;
  int comment_count;
  int likes;
  bool liked;
  Author author;

  PostModel({
    required this.id,
    required this.author,
    required this.body,
    required this.image_url,
    required this.updated_at,
    required this.likes,
    required this.comment_count,
    required this.liked,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json['id'],
        body: json['body'],
        likes: json['likes'],
        liked: json['liked'],
        comment_count: json['comment_count'],
        image_url: json['image_url'],
        updated_at: DateTime.parse(json['updated_at']),
        author: Author.fromJson(
          json['author'],
        ),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'body': body,
        'image': image_url,
        'updated_at': updated_at.toIso8601String(),
        'author': author.toJson(),
      };
}
