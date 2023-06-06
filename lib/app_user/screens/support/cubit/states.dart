abstract class SupportStates {}

class SupportInitialState extends SupportStates {}

class SupportLoadingState extends SupportStates {}

class SupportSuccessState extends SupportStates {}

class AddSupportSuccessState extends SupportStates {
  final String text;

  AddSupportSuccessState(this.text);
}

class SendSupportLoadingState extends SupportStates {}
class SendSupportSuccessState extends SupportStates {}

class SupportErrorState extends SupportStates {}
