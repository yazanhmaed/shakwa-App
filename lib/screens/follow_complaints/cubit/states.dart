abstract class FollowComplaintsStates {}

class FollowComplaintsInitialState extends FollowComplaintsStates {}

class FollowComplaintsLoadingState extends FollowComplaintsStates {}

class FollowComplaintsSuccessState extends FollowComplaintsStates {}

class FollowComplaintsErrorState extends FollowComplaintsStates {}

class FollowComplaintsLoading2State extends FollowComplaintsStates {}

class FollowComplaintsSuccess2State extends FollowComplaintsStates {}

class FollowComplaintsError2State extends FollowComplaintsStates {}

class FollowComplaintsImagePicLoadingState extends FollowComplaintsStates {}

class FollowComplaintsImagePicSuccessState extends FollowComplaintsStates {}

class GetUserLoadingState extends FollowComplaintsStates {}

class GetUserSuccessState extends FollowComplaintsStates {
  final String name;

  GetUserSuccessState(this.name);
}


class GetUserErrorState extends FollowComplaintsStates {}
class GetnameLoadingState extends FollowComplaintsStates {}
class GetnameState extends FollowComplaintsStates {}
class ChangeDrawState extends FollowComplaintsStates {}
class ChangeDrawErrorState extends FollowComplaintsStates {}