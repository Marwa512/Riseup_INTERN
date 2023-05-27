abstract class UserStates {}

class UserInitialState extends UserStates {}

class GetUserSuccessState extends UserStates {}

class GetUserErrorState extends UserStates {}

class DeleteUserSuccessState extends UserStates {}

class DeleteUserErrorState extends UserStates {}

class GetSelectedUserSuccessState extends UserStates {}

class GetSelectedUserErrorState extends UserStates {}

class CreateUserLoadingState extends UserStates {}

class CreateUserSuccessState extends UserStates {}

class CreateUserErrorState extends UserStates {
  CreateUserErrorState(String error);
}

class UpdateUserSuccessState extends UserStates {}

class UpdateUserErrorState extends UserStates {}

class SelectUserGenderState extends UserStates {}

class UpdateUserLoadingState extends UserStates {}
