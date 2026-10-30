abstract class SignupState {}

class SignupInitState extends SignupState {}

class SignupLoadingState extends SignupState {}

class SignupErrorState extends SignupState {
  final String errorMessage;

  SignupErrorState({required this.errorMessage});
}

class SignupSuccessState extends SignupState {
  final String successMessage;

  SignupSuccessState({required this.successMessage});
}

// Google account that is already an approved admin
class SignupGoogleSuccessState extends SignupState {}
