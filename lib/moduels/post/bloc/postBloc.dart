import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mob_final/moduels/post/bloc/postEvent.dart';
import 'package:mob_final/moduels/post/bloc/postState.dart';
import 'package:mob_final/moduels/post/bloc/postRepo.dart';
import 'package:mob_final/moduels/post/data/post.dart';


class PostBloc extends Bloc<PostEvent, PostState>{

  late PostRepository repository;

  PostBloc() : super(PostInitial())
  {
    repository = PostRepository();
    on<PublishPostEvent>(_onPublishPost);
    on<LikePostEvent>(_onLikePost);
    on<LoadPostEvent>(_onLoadPost);
  }

  Future<void> _onPublishPost(PublishPostEvent event, Emitter<PostState> emit)async {
    try{
      final published = await repository.publishPost(post: event.post);
      emit(PostLoading());
      List<Post> postList = await repository.loadPosts();

      if(published){
        emit(PostLoaded(posts: postList));
      }

      else{
        emit(PostFailure("Post publishing Failed"));
      }
    }
       catch (e) {
        emit(PostFailure(e.toString()));
    }
  }

  Future<void> _onLikePost(LikePostEvent event, Emitter<PostState> emit) async{
    try{

      final liked = await repository.likePost(post: event.post, userId: event.userId);      
      emit(PostLoading());
      List<Post> postList = await repository.loadPosts();

      if(liked){
        emit(PostLoaded(posts: postList));
      }

      else{
        emit(PostFailure("Post Liking Failed"));
      }
    }

    catch(e){
      emit(PostFailure(e.toString()));
    }
  }

  Future<void> _onLoadPost(LoadPostEvent event, Emitter<PostState> emit) async{
    try{ 
      emit(PostLoading());
      List<Post> postList = await repository.loadPosts();
      emit(PostLoaded(posts: postList));
    }

    catch(e){
      emit(PostFailure(e.toString()));
    }
  }
}