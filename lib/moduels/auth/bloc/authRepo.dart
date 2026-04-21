import 'package:firebase_auth/firebase_auth.dart';
import 'package:mob_final/services/dbClient.dart';
import 'package:mob_final/moduels/auth/data/user.dart';

class AuthRepository{
  late DbClient _dbClient;

  AuthRepository(){
    _dbClient = DbClient();
  }

  Future<bool> register({required String name, required String email, required String password}) async
  {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

    User? new_firebase_user = FirebaseAuth.instance.currentUser;
    if(new_firebase_user == null)
      return false;

    Profile profile = Profile(id: new_firebase_user.uid, name: name, email: email); 

    await _dbClient.createOrUpdateUser(profile.id!, profile);
    return Future.value(true);
  }

  bool checkAuth()
  {
    bool res = FirebaseAuth.instance.currentUser != null? true: false;
    return res;
  }

  Future<bool> logIn({required String email, required String password}) async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return Future.value(true);
  }
  
  Future<bool> logOut() async{
    await FirebaseAuth.instance.signOut();
    return Future.value(true);
  }
}