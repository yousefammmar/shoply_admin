import 'package:shoply_admin/core/utils/l10n/app_l10n.dart';

class ErrorHandleHelper {
  static String getCustomErrorMessage(String errorCode) {
    final l10n = appL10n;
    switch (errorCode) {
      case 'invalid-credential':
        return l10n.errorInvalidCredential;
      case 'email-already-in-use':
        return l10n.errorEmailInUse;
      case 'weak-password':
        return l10n.errorWeakPassword;
      case 'invalid-email':
        return l10n.errorInvalidEmail;
      case 'user-disabled':
        return l10n.errorUserDisabled;
      case 'too-many-requests':
        return l10n.errorTooManyRequests;
      default:
        return l10n.errorAuthUnexpected;
    }
  }
}
