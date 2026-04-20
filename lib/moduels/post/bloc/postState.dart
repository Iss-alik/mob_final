import 'package:firebase_auth/firebase_auth.dart';
import 'package:mob_final/moduels/post/data/post.dart';

abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState{}

class PostLoaded extends PostState{
  final List<Post> posts;

  PostLoaded({required this.posts});
}

class PostFailure extends PostState{
  final String error;

  PostFailure(this.error);

}