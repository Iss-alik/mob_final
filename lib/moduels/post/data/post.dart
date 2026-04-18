import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';


@JsonSerializable()
class Post {
  
  final String? id;
  final String authorId;
  final String postText;
  final Map<String, bool> likes;
  final int createdAt;

  const Post({
    this.id, 
    required this.authorId, 
    required this.postText,
    required this.likes,
    required this.createdAt});

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}