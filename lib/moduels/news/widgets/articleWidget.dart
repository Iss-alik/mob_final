import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mob_final/core/theme/colors.dart';
import 'package:mob_final/core/theme/spacing.dart';
import 'package:mob_final/core/theme/textStyles.dart';
import 'package:mob_final/moduels/news/data/article.dart';


class NewsWidget extends StatelessWidget{
  
  final Article article;

  const NewsWidget({
    super.key,
    required this.article,
  });
  
  @override
  Widget build(BuildContext context) {
    
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
              article.author ?? '[No name of author]',
              style: AppTextStyles.caption,
            ),

            Text(
              article.title,
              style: AppTextStyles.title,
            ),

            SizedBox(height: AppSpacing.s),

            Text(
              article.description ?? '',
              style: AppTextStyles.body,
            ),

            SizedBox(height: AppSpacing.m),
          ],
        ),
      ),
    );
  }
}