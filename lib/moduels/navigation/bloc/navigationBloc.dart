import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mob_final/moduels/navigation/bloc/navigationEvent.dart';
import 'package:mob_final/moduels/navigation/bloc/navigationState.dart';


class NavigationBloc extends Bloc<NavigationEvent, NavigationState>{

  NavigationBloc() : super(NavigationInitial())
  {
    on<ChangePageEvent>(_onChangePage);
  }

  Future<void> _onChangePage(ChangePageEvent event, Emitter<NavigationState> emit)async {
    try{
      emit(NavigationSuccess(event.index)) ; 
    }
    catch (e) {
        emit(NavigationFailure(e.toString()));
    }
  }

  
}