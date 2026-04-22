import 'package:mob_final/moduels/news/data/article.dart';
import 'package:mob_final/moduels/news/data/newsResponse.dart';
import 'package:mob_final/services/newsServices.dart';

class NewsRepository{
  late NewsClient _newsClient;

  NewsRepository(){
    _newsClient = NewsClient();
  }

  Future<List<Article>> loadArticles() async{
    NewsResponse response = await _newsClient.topHeadlines();
    List<Article> articleList = response.articles;
    return Future.value(articleList);
  }  
}