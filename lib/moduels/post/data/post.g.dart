// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      id: json['id'] as String,
      likes: json['likes'],
      authorId: json['authorId'] as String,
      postTitle: json['postTitle'] as String,
      postText: json['postText'] as String,
      createdAt: (json['createdAt'] as num).toInt(),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'postTitle': instance.postTitle,
      'postText': instance.postText,
      'likes': instance.likes,
      'createdAt': instance.createdAt,
    };
