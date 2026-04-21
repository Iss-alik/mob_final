abstract class ProfileEvent {}

class SetUsernameEvent extends ProfileEvent {
  final String newName;
  SetUsernameEvent(this.newName);
}
class ToggleThemeEvent extends ProfileEvent {}

class SetLanguageEvent extends ProfileEvent {
  final String newLanguage;
  SetLanguageEvent(this.newLanguage);
}