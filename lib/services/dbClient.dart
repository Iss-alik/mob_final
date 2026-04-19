import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:mob_final/moduels/auth/data/user.dart';
import 'package:mob_final/core/constants/db.dart';
import 'package:mob_final/moduels/post/data/post.dart';

part 'dbClient.g.dart';

const user_table = DbConstants.user_table;
const post_table = DbConstants.post_table;

@RestApi(baseUrl: DbConstants.base_url)
abstract class DbClient {
  factory DbClient({String? baseUrl})
  {
    final dio = Dio(); 
    dio.options.headers['Demo-Header'] = 'demo header';
    return _DbClient(dio);
  }

  // ==Users==
  @GET('/$user_table/{id}.json')
  Future<Profile> getUser(@Path() String id);

  @PUT('/$user_table/{id}.json')
  Future<void> createOrUpdateUser(
    @Path() String id,
    @Body() Profile profile,
  );

  // ==Posts==

  @GET('/$post_table.json')
  Future<Map<String, Post>?> getPosts();

  @PUT('/$post_table/{id}.json')
  Future<void> createOrUpdatePost(
    @Path() String id,
    @Body() Post post,
  );

  @DELETE('/$post_table/{id}.json')
  Future<void> deletePost(@Path() String id);

}


