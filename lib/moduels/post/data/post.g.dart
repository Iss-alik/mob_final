// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      id: json['id'] as String?,
      authorId: json['authorId'] as String,
      postText: json['postText'] as String,
      likes: Map<String, bool>.from(json['likes'] as Map),
      createdAt: (json['createdAt'] as num).toInt(),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'postText': instance.postText,
      'likes': instance.likes,
      'createdAt': instance.createdAt,
    };
