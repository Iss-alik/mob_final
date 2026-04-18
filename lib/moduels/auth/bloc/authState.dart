abstract class AuthState {}

class AuthInitial extends AuthState{}

class AuthLoggedIn extends AuthState{}

class AuthLoggedOut extends AuthState{}

class AuthFailure extends AuthState{
  final String error;

  AuthFailure(this.error);

}