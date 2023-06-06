abstract class CyberCrimesStates {}

class CyberCrimesInitialState extends CyberCrimesStates {}

class CyberCrimesLoadingState extends CyberCrimesStates {}

class CyberCrimesSuccessState extends CyberCrimesStates {}
class ChangeDrawState extends CyberCrimesStates {}
class ComplainChangeSwitchState extends CyberCrimesStates {}

class CyberCrimesErrorState extends CyberCrimesStates {
  final StateError error;

  CyberCrimesErrorState(this.error);
}

class CyberCrimesUpdateSuccessState extends CyberCrimesStates {}

class CyberCrimesUpdateErrorState extends CyberCrimesStates {}

class CyberCrimesRemoveSuccessState extends CyberCrimesStates {}
class CyberCrimesRemoveErrorState extends CyberCrimesStates {}

