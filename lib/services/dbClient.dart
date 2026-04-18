import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:mob_final/moduels/auth/data/user.dart';
import 'package:mob_final/core/constants/db.dart';
import 'package:mob_final/moduels/post/data/post.dart';

part 'dbClient.g.dart';

const user_table = DbConstants.user_table;
const post_table = DbConstants.post_table;

@RestApi(baseUrl: DbConstants.base_url)
abstract class DbClient {
  factory DbClient(Dio dio, {String? baseUrl}) = _DbClient;

  // ==Users==
  @GET('/$user_table./{id}.json')
  Future<User> getUser(@Path() String id);

  @PUT('/$user_table./{id}.json')
  Future<void> createOrUpdateUser(
    @Path() String id,
    @Body() User user,
  );

  // ==Posts==

  @GET('/$post_table.json')
  Future<Map<String, Post>?> getPosts();

  @PUT('/$user_table./{id}.json')
  Future<void> createOrUpdatePost(
    @Path() String id,
    @Body() Post post,
  );

  @DELETE('/$post_table/{id}.json')
  Future<void> deletePost(@Path() String id);

}


