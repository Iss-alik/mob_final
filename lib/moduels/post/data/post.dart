import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';


@JsonSerializable()
class Post {
  
  final String id;
  final String authorId;
  String? authorName;
  final String postTitle;
  final String postText;
  final List<dynamic> likes;
  final int createdAt;

  Post({
    required this.id,
    likes, 
    required this.authorId,
    this.authorName,
    required this.postTitle, 
    required this.postText,
    required this.createdAt
  }): this.likes = likes ?? [];

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);

  Post copyWith({
    String? id,
    String? authorId,
    String? authorName,
    String? postTitle,
    String? postText,
    List<dynamic>? likes,
    int? createdAt,}) {
      return Post(
        id: id ?? this.id,
        authorId: authorId ?? this.authorId,
        authorName: authorName ?? this.authorName,
        postTitle: postTitle ?? this.postTitle,
        postText: postText ?? this.postText,
        likes: likes ?? this.likes,
        createdAt: createdAt ?? this.createdAt,
      );
    }
  
}