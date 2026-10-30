import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shoply_admin/core/model/settings/store_settings_model.dart';
import 'package:shoply_admin/core/utils/l10n/app_l10n.dart';

class StoreSettingsRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // all store settings are saved in one document: settings/store
  DocumentReference<Map<String, dynamic>> _settingsRef() {
    return _firestore.collection('settings').doc('store');
  }

  Future<Either<String, StoreSettingsModel>> getSettings() async {
    try {
      final snapshot = await _settingsRef().get();
      return Right(StoreSettingsModel.fromMap(snapshot.data() ?? {}));
    } on FirebaseException {
      return Left(appL10n.loadSettingsFailed);
    }
  }

  Future<Either<String, bool>> saveSettings(StoreSettingsModel settings) async {
    try {
      await _settingsRef().set(settings.toMap(), SetOptions(merge: true));
      return Right(true);
    } on FirebaseException {
      return Left(appL10n.saveSettingsFailed);
    }
  }
}
