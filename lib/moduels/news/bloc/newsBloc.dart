import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mob_final/moduels/news/bloc/newsEvents.dart';
import 'package:mob_final/moduels/news/bloc/newsRepo.dart';
import 'package:mob_final/moduels/news/bloc/newsState.dart';
import 'package:mob_final/moduels/news/data/article.dart';


class NewsBloc extends Bloc<NewsEvent, NewsState>{

  late NewsRepository repository;

  NewsBloc() : super(NewsInitial())
  {
    repository = NewsRepository();
    on<LoadNewsEvent>(_onLoadNews);
  }

  Future<void> _onLoadNews(LoadNewsEvent event, Emitter<NewsState> emit) async{
    try{ 
      emit(NewsLoading());
      List<Article> articleList = await repository.loadArticles();
      emit(NewsLoaded(articles: articleList));
    }

    catch(e){
      print(e);
      emit(NewsFailure(e.toString()));
    }
  }
}