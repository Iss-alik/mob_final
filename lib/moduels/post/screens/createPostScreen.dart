import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mob_final/core/theme/spacing.dart';
import 'package:mob_final/core/theme/textStyles.dart';
import 'package:mob_final/core/widgets/inputField.dart';
import 'package:mob_final/moduels/navigation/bloc/navigationBloc.dart';
import 'package:mob_final/moduels/navigation/bloc/navigationEvent.dart';
import 'package:mob_final/moduels/post/bloc/postBloc.dart';
import 'package:mob_final/moduels/post/bloc/postEvent.dart';
import 'package:mob_final/moduels/post/bloc/postState.dart';
import 'package:mob_final/moduels/post/data/post.dart';
import 'package:mob_final/services/validation.dart';

class CreatPostPage extends StatefulWidget {
  const CreatPostPage({super.key});

  @override
  State<CreatPostPage> createState() => _CreatPostPageState();
}

class _CreatPostPageState extends State<CreatPostPage>{

  String? postTitle;
  String? postText;

  final _formKey = GlobalKey<FormState>();

  final _postTitleFocus = FocusNode();
  final _postTextFocus = FocusNode();


  @override
  void dispose() {
    _postTitleFocus.dispose();
    _postTextFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  { 
    
    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {
        if(state is PostFailure)
        {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error))
          );
        }

        else if(state is PostLoading)
        {
          context.read<NavigationBloc>().add(ChangePageEvent(0));
        }

      },

      child: Scaffold(
      body: Form(
        key: _formKey, 
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(AppSpacing.s),
              child: Center(
                  child: Text("Create your post", style: AppTextStyles.title)
                ),
            ),

            InputField(validationFuncs: [Validators.notEmpty],
            label: "Post's Title",
            icon: Icons.text_format,
            onSaved: (value) => postTitle = value,
            focusNode: _postTitleFocus,
            onFieldSubmitted:  (_) => FocusScope.of(context).requestFocus(_postTextFocus),
            ),

            InputField(
            validationFuncs: [Validators.notEmpty], 
            label: "Text of your post", 
            onSaved: (value) => postText = value,
            focusNode: _postTextFocus,
            minLines: 3,
            maxLines: 8,
            ),

            SizedBox(height: AppSpacing.s),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).cardColor,
                  foregroundColor: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
              onPressed: (){
                if (_formKey.currentState!.validate()) 
                {
                  _formKey.currentState!.save(); 
                  
                  String userId = FirebaseAuth.instance.currentUser!.uid;
                  int createdAt = DateTime.now().millisecondsSinceEpoch;
                  String key = createdAt.toString();

                  Post new_post = Post(id: key, authorId: userId, postTitle: postTitle!, postText: postText!, createdAt: createdAt);

                  context.read<PostBloc>().add(
                    PublishPostEvent(
                      post: new_post,
                    ),
                  );
                }
              }, 
              child: Text("Create post")
            ),
          ],
        ),
        
      )
    )
    );
    
  }
}