import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mob_final/moduels/auth/bloc/authRepo.dart';
import 'package:mob_final/moduels/post/bloc/postBloc.dart';
import 'package:mob_final/moduels/post/bloc/postEvent.dart';
import 'package:mob_final/moduels/post/bloc/postState.dart';
import 'package:mob_final/moduels/post/data/post.dart';
import 'package:mob_final/moduels/post/widgets/postWidget.dart'; 

class PostFeedPage extends StatefulWidget {
  const PostFeedPage({super.key});

  @override
  State<PostFeedPage> createState() => _PostFeedPageState();
}

class _PostFeedPageState extends State<PostFeedPage>{
  @override
  Widget build(BuildContext context)
  { 
    return BlocConsumer<PostBloc, PostState>(
      listener: (context, state) {
        if(state is PostFailure)
        {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error))
          );
        }
      },

      builder: (context, state){
        if(state is PostLoaded ){
          List<Post> posts = state.posts;
          String userId = FirebaseAuth.instance.currentUser!.uid;
          return Scaffold(
            body: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return PostWidget(
                  post: post,
                  onLike: () {
                    context.read<PostBloc>().add(
                      LikePostEvent(post: post, userId: userId),
                    );
                  },
                  myUserId: userId,
                );
              },
            ),
          );
        }

        else 
        {
          return Scaffold(
            body: CircularProgressIndicator(),
          );
        }

      }
    );

  }
}