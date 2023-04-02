abstract class AddComplaintStates {}

class AddComplaintInitialState extends AddComplaintStates {}

class AddComplaintLoadingState extends AddComplaintStates {}

class AddComplaintSuccessState extends AddComplaintStates {}

class AddComplaintErrorState extends AddComplaintStates {
  final String error;

  AddComplaintErrorState(this.error);
}

class AddComplaintLoading2State extends AddComplaintStates {}

class AddComplaintSuccess2State extends AddComplaintStates {}

class AddComplaintError2State extends AddComplaintStates {}

class AddComplaintImagePicLoadingState extends AddComplaintStates {}

class AddComplaintImagePicSuccessState extends AddComplaintStates {}

class AddComplainImagePicErrorState extends AddComplaintStates {}

class AddComplainGeolocatorState extends AddComplaintStates {}

class AddComplainChangeSwitchState extends AddComplaintStates {}
