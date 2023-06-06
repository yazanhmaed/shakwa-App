abstract class UserStates {}

class UserInitialState extends UserStates {}

class UserLoadingState extends UserStates {}

class UserSuccessState extends UserStates {
  final String uId;
  final String email;

  UserSuccessState(this.uId, this.email);
}

class UserErrorState extends UserStates {}

class CreateUserErrorState extends UserStates {}

class GetUserSuccessState extends UserStates {
  final String name;

  GetUserSuccessState(this.name);
}

class ChangeSuccessState extends UserStates {}

class EmailVerifySuccessState extends UserStates {}

class EmailVerifyErrorState extends UserStates {}

class PasswordResetSuccessState extends UserStates {}

class PasswordResetErrorState extends UserStates {}

class ChangeobscureTextSuccessState extends UserStates {}

class AddUserLoadingState extends UserStates {}

class AddUserSuccessState extends UserStates {}

class AddUserErrorState extends UserStates {
  final String error;

  AddUserErrorState(this.error);
}

class AddCreateUserSuccessState extends UserStates {}

class LogoutSuccessState extends UserStates {}

class LogoutErrorState extends UserStates {}

class ChangeDrawState extends UserStates {}
