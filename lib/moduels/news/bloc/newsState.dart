import 'package:mob_final/moduels/news/data/article.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState{}

class NewsLoaded extends NewsState{
  final List<Article> articles;

  NewsLoaded({required this.articles});
}

class NewsFailure extends NewsState{
  final String error;

  NewsFailure(this.error);

}