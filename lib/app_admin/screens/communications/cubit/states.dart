abstract class CommunicationsStates {}

class CommunicationsInitialState extends CommunicationsStates {}

class CommunicationsLoadingState extends CommunicationsStates {}

class CommunicationsSuccessState extends CommunicationsStates {}
class ChangeDrawState extends CommunicationsStates {}

class CommunicationsErrorState extends CommunicationsStates {
  final String error;

  CommunicationsErrorState(this.error);
}

class CommunicationsUpdateSuccessState extends CommunicationsStates {}

class CommunicationsUpdateErrorState extends CommunicationsStates {}

class CommunicationsRemoveSuccessState extends CommunicationsStates {}
class CommunicationsRemoveErrorState extends CommunicationsStates {}

