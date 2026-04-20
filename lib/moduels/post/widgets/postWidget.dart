import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mob_final/core/theme/colors.dart';
import 'package:mob_final/core/theme/spacing.dart';
import 'package:mob_final/core/theme/textStyles.dart';
import 'package:mob_final/moduels/post/data/post.dart';

class PostWidget extends StatelessWidget{
  
  final Post post;
  final VoidCallback onLike;
  final String myUserId;

  const PostWidget({
    super.key,
    required this.post,
    required this.onLike,
    required this.myUserId
  });
  
  @override
  Widget build(BuildContext context) {
    
    final isLiked = post.likes.contains(myUserId);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: AppSpacing.s),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.m)
      ),

      child: Padding(
        padding: EdgeInsets.all(AppSpacing.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.postTitle,
              style: AppTextStyles.title,
            ),

            SizedBox(height: AppSpacing.xs),

            Text(
              post.postText,
              style: AppTextStyles.body,
            ),

            SizedBox(height: AppSpacing.m),

            Row(
              children: [
                IconButton(
                  onPressed: (onLike), 
                  icon: Icon(
                    isLiked? Icons.favorite : Icons.favorite_border,
                    color: AppColors.like,
                  ),
                ),
                Text('${post.likes.length}')
              ],
            )
          ],
        ),
      ),
    );
  }
}