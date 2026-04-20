import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';


@JsonSerializable()
class Post {
  
  final String id;
  final String authorId;
  final String postTitle;
  final String postText;
  final List<dynamic> likes;
  final int createdAt;

  Post({
    required this.id,
    likes, 
    required this.authorId,
    required this.postTitle, 
    required this.postText,
    required this.createdAt
  }): this.likes = likes ?? [];

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}