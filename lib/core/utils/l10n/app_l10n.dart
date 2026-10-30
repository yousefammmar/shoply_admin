import 'package:flutter/widgets.dart';
import 'package:shoply_admin/core/local/local_storage.dart';
import 'package:shoply_admin/l10n/app_localizations.dart';

export 'package:shoply_admin/l10n/app_localizations.dart';

extension AppL10nContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

// For code without a BuildContext (cubits, use cases), uses the saved app language
AppLocalizations get appL10n =>
    lookupAppLocalizations(Locale(LocalStorage.instance.getLanguageCode()));
