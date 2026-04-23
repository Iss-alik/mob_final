import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mob_final/moduels/profile/bloc/profileEvent.dart';
import 'package:mob_final/moduels/profile/bloc/profileRepo.dart';
import 'package:mob_final/moduels/profile/bloc/profileState.dart';



class ProfileBloc extends Bloc<ProfileEvent, ProfileState>{

  late ProfileRepository repository;

  ProfileBloc(): super(ProfileState(language: 'en', username: '', isDark: true))
  {
    repository = ProfileRepository();
    on<SetUsernameEvent>(_onSetName);
    on<SetLanguageEvent>(_onSetLanguage);
    on<ToggleThemeEvent>(_onToggleTheme);
    on<LoadProfile>(_loadProfile);
    on<ClearProfile>(_clearProfile);

    add(LoadProfile()); 
  }

  Future<void> _onSetName(SetUsernameEvent event, Emitter<ProfileState> emit)async {
    var curState = state;
    try{
      emit(ProfileState(username: event.newName, isDark: curState.isDark, language: curState.language));
      if(!event.isLocal)
        repository.setName(event.newName);
    }
       catch (e) {
        emit(curState);
    }
  }

  Future<void> _onSetLanguage(SetLanguageEvent event, Emitter<ProfileState> emit) async{
    
    final currentState = state;

    try{
      emit(ProfileState(username: currentState.username, isDark: currentState.isDark, language: event.newLanguage));
      repository.setLanguage(event.newLanguage);
    }
    
    catch(e){
      emit(currentState);
    }
  }

  Future<void> _onToggleTheme(ToggleThemeEvent event, Emitter<ProfileState> emit) async{
    var curState = state;
    try{ 
      emit(ProfileState(username: curState.username, isDark: !curState.isDark, language: curState.language));
      repository.toggleTheme(curState.isDark);
    }

    catch(e){
      emit(curState);
    }
  }

  Future<void> _loadProfile(LoadProfile event, Emitter<ProfileState> emit) async{
    await repository.init(); 
    List<dynamic> preferences = await repository.loadPreferences();
    emit(ProfileState(username: preferences[0], isDark: preferences[2], language: preferences[1]));
  }

  Future<void> _clearProfile(ClearProfile event, Emitter<ProfileState> emit) async{
    await repository.clearPrefs();
    emit(ProfileState(username: '', isDark: true, language: 'en'));
  }
}