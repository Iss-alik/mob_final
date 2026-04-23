abstract class ProfileEvent {}

class SetUsernameEvent extends ProfileEvent {
  final String newName;
  final bool isLocal;
  SetUsernameEvent({required this.newName, this.isLocal = false});
}
class ToggleThemeEvent extends ProfileEvent {}

class SetLanguageEvent extends ProfileEvent {
  final String newLanguage;
  SetLanguageEvent(this.newLanguage);
}

class LoadProfile extends ProfileEvent{}

class ClearProfile extends ProfileEvent{}