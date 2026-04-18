abstract class AuthEvent {}

class RegisterEvent extends AuthEvent{
  final String email;
  final String name;
  final String password;

  RegisterEvent({required this.name, required this.email, required this.password});
}

class AuthCheckEvent extends AuthEvent{
  AuthCheckEvent();
}