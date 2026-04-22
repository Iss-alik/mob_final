import 'package:json_annotation/json_annotation.dart';
import 'package:mob_final/moduels/news/data/article.dart';

part 'newsResponse.g.dart';


@JsonSerializable()
class NewsResponse {
  final List<Article> articles;

  NewsResponse({required this.articles});

  factory NewsResponse.fromJson(Map<String, dynamic> json) =>
      _$NewsResponseFromJson(json);
}