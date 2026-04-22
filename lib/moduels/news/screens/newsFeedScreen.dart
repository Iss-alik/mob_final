import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mob_final/moduels/news/bloc/newsBloc.dart';
import 'package:mob_final/moduels/news/bloc/newsState.dart';
import 'package:mob_final/moduels/news/data/article.dart';
import 'package:mob_final/moduels/news/widgets/articleWidget.dart';


class NewsFeedPage extends StatefulWidget {
  const NewsFeedPage({super.key});

  @override
  State<NewsFeedPage> createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage>{
  @override
  Widget build(BuildContext context)
  { 
    return BlocConsumer<NewsBloc, NewsState>(
      listener: (context, state) {
        if(state is NewsFailure)
        {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error))
          );
        }
      },

      builder: (context, state){
        if(state is NewsLoaded ){
          List<Article> articles = state.articles;
          return Scaffold(
            body: ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final post = articles[index];
                return NewsWidget(
                  article: post,
                );
              },
            ),
          );
        }

        else 
        {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator()
            ),
          );
        }

      }
    );

  }
}