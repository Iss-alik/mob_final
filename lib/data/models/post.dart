import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';


@JsonSerializable()
class Post {
  
  final int id;
  final int authorId;
  final String postText;
  final List<int> likes;

  const Post({
    required this.id, 
    required this.authorId, 
    required this.postText,
    required this.likes});

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}