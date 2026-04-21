import 'package:firebase_auth/firebase_auth.dart';
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
    on<LogInEvent>(_onLigIn);
    on<LogOutEvent>(_onLogOut);
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
      on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          emit(AuthFailure('The password provided is too weak.'));
        } else if (e.code == 'email-already-in-use') {
          emit(AuthFailure('The account already exists for that email.'));
        }
      } catch (e) {
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

  Future<void> _onLigIn(LogInEvent event, Emitter<AuthState> emit) async{
    try{
      final logedIn = await repository.logIn(email: event.email, password: event.password);
      
      if(logedIn){
        emit(AuthLoggedIn());
      }

      else{
        emit(AuthLoggedOut());
      }
    }

    on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthFailure('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(AuthFailure('Wrong password provided for that user.'));
      }
      else 
        emit(AuthFailure(e.toString()));
    }

    catch(e){
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onLogOut(LogOutEvent event, Emitter<AuthState> emit) async{
    bool logOut = await repository.logOut();
    if(logOut)
      emit(AuthLoggedOut());
  }
}