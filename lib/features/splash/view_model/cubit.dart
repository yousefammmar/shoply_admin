import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_admin/core/local/local_storage.dart';
import 'package:shoply_admin/core/local/local_storage_user.dart';
import 'package:shoply_admin/features/splash/view_model/state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitState());

  void goNextPage() async {
    bool? isLogin = LocalStorage.instance.getIsLogin();

    await Future.delayed(Duration(seconds: 2)).then((value) async {
      if ((isLogin ?? false) && FirebaseAuth.instance.currentUser != null) {
        final responseLogin = await LocalStorageUser.instance.getUserData();
        LocalStorageUser.instance.setUserinfo(responseLogin: responseLogin);
        emit(SplashHomePageState());
      } else {
        await LocalStorageUser.instance.clearUserData();
        emit(SplashLoginPageState());
      }
    });
  }
}
