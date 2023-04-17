abstract class AddCommunicationsStates {}

class AddCommunicationsInitialState extends AddCommunicationsStates {}

class AddCommunicationsLoadingState extends AddCommunicationsStates {}

class AddCommunicationsSuccessState extends AddCommunicationsStates {}

class AddCommunicationsErrorState extends AddCommunicationsStates {
  final StateError error;

  AddCommunicationsErrorState(this.error);
}

class AddCommunicationsLoading2State extends AddCommunicationsStates {}

class AddCommunicationsSuccess2State extends AddCommunicationsStates {}

class AddCommunicationsError2State extends AddCommunicationsStates {}

class AddCommunicationsImagePicLoadingState extends AddCommunicationsStates {}

class AddCommunicationsImagePicSuccessState extends AddCommunicationsStates {}

class AddComplainImagePicErrorState extends AddCommunicationsStates {}

class AddComplainGeolocatorState extends AddCommunicationsStates {}

class AddComplainChangeSwitchState extends AddCommunicationsStates {}
class AddComplainChangeSwitch2State extends AddCommunicationsStates {}
