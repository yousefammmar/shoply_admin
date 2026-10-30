import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shoply_admin/core/helper/error_handle_helper.dart';
import 'package:shoply_admin/core/model/login/request_login.dart';
import 'package:shoply_admin/core/model/login/response_login.dart';
import 'package:shoply_admin/core/utils/l10n/app_l10n.dart';

class LoginUsecase {
  Future<Either<String, ResponseLogin>> login({
    required RequestLogin requestLogin,
  }) async {
    try {
      final snapshot = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: requestLogin.email ?? '',
        password: requestLogin.password ?? '',
      );

      final user = snapshot.user;
      return await _getAdminInfo(user: user!);
    } on FirebaseAuthException catch (e) {
      final error = ErrorHandleHelper.getCustomErrorMessage(e.code);
      return Left(error);
    }
  }

  Future<Either<String, ResponseLogin>> loginWithGoogle() async {
    try {
      final provider = GoogleAuthProvider();
      final snapshot = kIsWeb
          ? await FirebaseAuth.instance.signInWithPopup(provider)
          : await FirebaseAuth.instance.signInWithProvider(provider);

      final user = snapshot.user;

      // First time with Google: ask the owner for access
      if (snapshot.additionalUserInfo?.isNewUser ?? false) {
        await FirebaseFirestore.instance
            .collection('adminRequests')
            .doc(user!.uid)
            .set({
              'fullName': user.displayName ?? '',
              'email': user.email ?? '',
              'createdAt': FieldValue.serverTimestamp(),
            });
      }

      return await _getAdminInfo(user: user!);
    } on FirebaseAuthException {
      return Left(appL10n.googleSignInFailed);
    }
  }

  // Only users the owner added to the admins collection can log in
  Future<Either<String, ResponseLogin>> _getAdminInfo({
    required User user,
  }) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('admins')
          .doc(user.uid)
          .get();

      if (!snapshot.exists) {
        await FirebaseAuth.instance.signOut();
        return Left(appL10n.accountPendingApproval);
      }

      final data = snapshot.data();

      final responseLogin = ResponseLogin(
        uid: user.uid,
        email: data?['email'] ?? user.email ?? '',
        address: '',
        fullName: data?['name'] ?? user.displayName ?? '',
        userName: '',
        profileImage: user.photoURL,
      );

      return Right(responseLogin);
    } on FirebaseException {
      await FirebaseAuth.instance.signOut();
      return Left(appL10n.errorAuthUnexpected);
    }
  }
}
