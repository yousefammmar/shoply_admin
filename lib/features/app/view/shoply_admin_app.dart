import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_admin/core/routes/app_pages.dart';
import 'package:shoply_admin/core/routes/app_routes.dart';
import 'package:shoply_admin/core/utils/l10n/app_l10n.dart';
import 'package:shoply_admin/core/utils/theme/app_theme.dart';
import 'package:shoply_admin/features/app/view_model/cubit.dart';
import 'package:shoply_admin/features/app/view_model/state.dart';

class ShoplyAdminApp extends StatelessWidget {
  const ShoplyAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppSettingsCubit(),
      child: BlocBuilder<AppSettingsCubit, AppSettingsState>(
        builder: (context, settings) {
          return MaterialApp(
            onGenerateTitle: (context) => context.l10n.appTitle,
            onGenerateRoute: AppRoutes.onGenerateRoute,
            initialRoute: AppPages.splashScreen,
            debugShowCheckedModeBanner: false,
            locale: settings.locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            theme: AppTheme.themeLight,
            darkTheme: AppTheme.themeDark,
            themeMode: settings.themeMode,
          );
        },
      ),
    );
  }
}
