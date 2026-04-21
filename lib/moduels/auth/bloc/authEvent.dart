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

class LogInEvent extends AuthEvent{
  final String email;
  final String password;

  LogInEvent({required this.email, required this.password});
}

class LogOutEvent extends AuthEvent{
  LogOutEvent();
}