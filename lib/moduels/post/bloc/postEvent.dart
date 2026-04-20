import 'package:firebase_auth/firebase_auth.dart';
import 'package:mob_final/moduels/post/data/post.dart';

abstract class PostEvent{}

class PublishPostEvent extends PostEvent{
  final Post post;

  PublishPostEvent(
    {
      required this.post
    }
  );
}

class LikePostEvent extends PostEvent{
  final String userId;
  final Post post;
  LikePostEvent({required this.post, required this.userId});
}

class LoadPostEvent extends PostEvent{
  LoadPostEvent();
}
