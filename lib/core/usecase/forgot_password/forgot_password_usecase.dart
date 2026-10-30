import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoply_admin/core/helper/error_handle_helper.dart';

class ForgotPasswordUsecase {
  Future<Either<String, bool>> forgotPassword({required String email}) async {
    try {
      final actionCodeSettings = ActionCodeSettings(
        iOSBundleId: 'com.example.shoply_admin',
        androidPackageName: 'com.example.shoply_admin',
        handleCodeInApp: true,
        url:
            'https://shoply-e25f0.firebaseapp.com/__/auth/action?mode=action&oobCode=code',
      );

      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
        actionCodeSettings: actionCodeSettings,
      );
      return Right(true);
    } on FirebaseAuthException catch (e) {
      return Left(ErrorHandleHelper.getCustomErrorMessage(e.code));
    }
  }
}
