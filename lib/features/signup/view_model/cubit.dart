import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_admin/core/local/local_storage.dart';
import 'package:shoply_admin/core/local/local_storage_user.dart';
import 'package:shoply_admin/features/login/repo/login_repo.dart';
import 'package:shoply_admin/features/signup/repo/signup_repo.dart';
import 'package:shoply_admin/features/signup/view_model/state.dart';
import 'package:shoply_admin/core/utils/l10n/app_l10n.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitState());
  final _signupRepo = SignupRepo();
  final _loginRepo = LoginRepo();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> signup() async {
    if (formKey.currentState?.validate() ?? false) {
      emit(SignupLoadingState());
      final result = await _signupRepo.signup(
        fullName: fullNameController.text,
        email: emailController.text,
        password: passwordController.text,
      );
      result.fold(
        (errorMessage) {
          emit(SignupErrorState(errorMessage: errorMessage));
        },
        (_) {
          emit(
            SignupSuccessState(successMessage: appL10n.signupSuccessMessage),
          );
        },
      );
    }
  }

  Future<void> signupWithGoogle() async {
    emit(SignupLoadingState());
    final result = await _loginRepo.loginWithGoogle();
    await result.fold(
      (errorMessage) async {
        emit(SignupErrorState(errorMessage: errorMessage));
      },
      (responseLogin) async {
        await LocalStorage.instance.setIsLogin(isLogin: true);
        await LocalStorageUser.instance.setUserData(
          responseLogin: responseLogin,
        );
        LocalStorageUser.instance.setUserinfo(responseLogin: responseLogin);
        emit(SignupGoogleSuccessState());
      },
    );
  }

  @override
  Future<void> close() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
