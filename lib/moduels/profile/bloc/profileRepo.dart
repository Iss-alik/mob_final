
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mob_final/moduels/auth/data/user.dart';
import 'package:mob_final/services/dbClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepository {
  late SharedPreferencesWithCache prefences;
  late DbClient _dbClient;

  ProfileRepository(){
    initPref();
    _dbClient = DbClient();
  }

  void initPref() async{
    prefences = await SharedPreferencesWithCache.create(
      cacheOptions: SharedPreferencesWithCacheOptions(
        allowList: <String>{'name', 'language', 'isDark'}, 
      )
    );
  }

  void setName(String name) async{
    String userId = FirebaseAuth.instance.currentUser!.uid;
    Profile user = await _dbClient.getUser(userId); 
    user.name = name;
    await _dbClient.createOrUpdateUser(userId, user);
    await prefences.setString('name', name);
  }

  void setLanguage(String language) async{
    await prefences.setString('language', language);
  }

  void toggleTheme(bool isDark) async{
      await prefences.setBool('isDark', !isDark);
  }
}