import 'package:firebase_auth/firebase_auth.dart';
import 'package:mob_final/moduels/auth/data/user.dart';
import 'package:mob_final/services/dbClient.dart';
import 'package:mob_final/moduels/post/data/post.dart';

class PostRepository{
  late DbClient _dbClient;

  PostRepository(){
    _dbClient = DbClient();
  }

  Future<List<Post>> loadPosts() async{
    Map<String, Post>? postsMap = {};

    postsMap = await _dbClient.getPosts();

    if(postsMap!.isEmpty) 
      throw("There is no posts");

    List<Post> postsList = postsMap.values.toList();
    postsList.sort((a, b) => b.createdAt.compareTo(a.createdAt)); 

    return Future.value(postsList);
  }

  Future<bool> publishPost({required Post post}) async{
    Profile user = await _dbClient.getUser(post.authorId);
    post.authorName = user.name;
    _dbClient.createOrUpdatePost(post.id, post);
    return Future.value(true);
  }

  Future<bool> likePost({required Post post, required String userId}) async{
    if(post.likes.contains(userId))
      post.likes.remove(userId);
    else 
      post.likes.add(userId);
    _dbClient.createOrUpdatePost(post.id, post);
    return Future.value(true);
  }

  

}