abstract class FollowComplaintsStates {}

class FollowComplaintsInitialState extends FollowComplaintsStates {}

class FollowComplaintsLoadingState extends FollowComplaintsStates {}

class FollowComplaintsSuccessState extends FollowComplaintsStates {}

class FollowComplaintsErrorState extends FollowComplaintsStates {}

class FollowRemoveSuccessState extends FollowComplaintsStates {}

class FollowRemoveErrorState extends FollowComplaintsStates {}

class GetUserLoadingState extends FollowComplaintsStates {}

class GetUserSuccessState extends FollowComplaintsStates {
  final String name;

  GetUserSuccessState(this.name);
}

class GetUserErrorState extends FollowComplaintsStates {}

class ComplaintsUpdateSuccessState extends FollowComplaintsStates {}

class ComplaintsUpdateErrorState extends FollowComplaintsStates {}
