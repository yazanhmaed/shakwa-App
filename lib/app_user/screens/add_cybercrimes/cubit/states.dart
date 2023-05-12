abstract class AddCyberCrimesStates {}

class AddCyberCrimesInitialState extends AddCyberCrimesStates {}

class AddCyberCrimesLoadingState extends AddCyberCrimesStates {}

class AddCyberCrimesSuccessState extends AddCyberCrimesStates {}

class AddCyberCrimesErrorState extends AddCyberCrimesStates {
  final StateError error;

  AddCyberCrimesErrorState(this.error);
}

class AddCyberCrimesLoading2State extends AddCyberCrimesStates {}

class AddCyberCrimesSuccess2State extends AddCyberCrimesStates {}

class AddCyberCrimesError2State extends AddCyberCrimesStates {}

class AddCyberCrimesImagePicLoadingState extends AddCyberCrimesStates {}

class AddCyberCrimesImagePicSuccessState extends AddCyberCrimesStates {}

class AddComplainImagePicErrorState extends AddCyberCrimesStates {}

class AddComplainGeolocatorState extends AddCyberCrimesStates {}

class AddComplainChangeSwitchState extends AddCyberCrimesStates {}
class AddComplainChangeSwitch2State extends AddCyberCrimesStates {}
