import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoply_admin/core/helper/error_handle_helper.dart';
import 'package:shoply_admin/core/utils/l10n/app_l10n.dart';

class SignupUsecase {
  Future<Either<String, bool>> signup({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      // 1. Create Firebase Authentication account
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password,
          );

      final user = credential.user;

      if (user == null) {
        return Left(appL10n.failedCreateAccount);
      }

      await user.updateDisplayName(fullName.trim());

      // 2. Save the request, the owner approves it from the Firebase console
      await FirebaseFirestore.instance
          .collection('adminRequests')
          .doc(user.uid)
          .set({
            'fullName': fullName.trim(),
            'email': email.trim(),
            'createdAt': FieldValue.serverTimestamp(),
          });

      // 3. Can't use the app until approved
      await FirebaseAuth.instance.signOut();

      return const Right(true);
    } on FirebaseAuthException catch (e) {
      log('Firebase Auth Error: ${e.message}');
      return Left(ErrorHandleHelper.getCustomErrorMessage(e.code));
    } on FirebaseException catch (e) {
      log('Firestore Error: ${e.message}');
      return Left(appL10n.failedSendRequest);
    }
  }
}
