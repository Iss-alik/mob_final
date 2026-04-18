import 'package:mob_final/moduels/auth/bloc/authState.dart';
import 'package:mob_final/moduels/auth/bloc/authEvent.dart';
import 'package:mob_final/moduels/auth/bloc/authRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState>{

  late AuthRepository repository;

  AuthBloc() : super(AuthInitial())
  {
    repository = AuthRepository();
    on<RegisterEvent>(_onRegister);
    on<AuthCheckEvent>(_onAuthCheck);
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit)async {
    try{
      final success = await repository.register(name: event.name, email: event.email, password: event.password);
      
      if(success){
        emit(AuthLoggedIn());
      }

      else{
        emit(AuthFailure("Registraion Failed"));
      }
    }

    catch(e){
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onAuthCheck(AuthCheckEvent event, Emitter<AuthState> emit) async{
    try{
      final authentified = repository.checkAuth();
      
      if(authentified){
        emit(AuthLoggedIn());
      }

      else{
        emit(AuthLoggedOut());
      }
    }

    catch(e){
      emit(AuthFailure(e.toString()));
    }
  }
}