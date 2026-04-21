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
    
    final currentState = state;
    if(currentState is PostLoaded){ 
      List<Post> updatedPosts = currentState.posts.map( 
        (post) {
          if(post.id == event.post.id)
          {
            final isLiked = post.likes.contains(event.userId);

            final updatedLikes = isLiked
              ? post.likes.where((id) => id != event.userId).toList()
              : [...post.likes, event.userId];

            return post.copyWith(likes: updatedLikes);
          }
          return post;
        }
      ).toList();

      emit(PostLoaded(posts: updatedPosts));
    }

    try{
      await repository.likePost(post: event.post, userId: event.userId); 
      await repository.loadPosts();
    }
    
    catch(e){
      emit(currentState);
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