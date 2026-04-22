import 'package:dio/dio.dart';
import 'package:mob_final/moduels/news/data/article.dart';
import 'package:mob_final/moduels/news/data/newsResponse.dart';
import 'package:retrofit/retrofit.dart';
import 'package:mob_final/core/constants/news.dart';


part 'newsServices.g.dart';

const String apiKeyConst = NewsConstants.apikey;

@RestApi(baseUrl: NewsConstants.base_url)
abstract class NewsClient {
  factory NewsClient({String? baseUrl})
  {
    final dio = Dio(); 
    dio.options.headers['Demo-Header'] = 'demo header';
    return _NewsClient(dio);
  }

  @GET('/top-headlines')
  Future<NewsResponse> topHeadlines({
    @Query('country') String country = 'kz',
    @Query('apiKey') String apiKey = apiKeyConst,
  });
}


