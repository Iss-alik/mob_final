abstract class NavigationState {}

class NavigationInitial extends NavigationState{}

class NavigationSuccess extends NavigationState{
  final int pageIndex;
  NavigationSuccess(this.pageIndex);
}

class NavigationFailure extends NavigationState{
  final String error;
  NavigationFailure(this.error);
}
