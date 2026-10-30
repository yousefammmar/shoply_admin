import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoply_admin/core/local/local_storage.dart';
import 'package:shoply_admin/core/navigation/widget/admin_bottom_nav_bar.dart';
import 'package:shoply_admin/core/utils/theme/app_colors.dart';
import 'package:shoply_admin/core/utils/theme/app_theme.dart';
import 'package:shoply_admin/features/app/view_model/cubit.dart';
import 'package:shoply_admin/l10n/app_localizations.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await LocalStorage.instance.initSharedPreferences();
  });

  test('language and theme are saved and restored on the next start', () async {
    final cubit = AppSettingsCubit();
    expect(cubit.state.themeMode, ThemeMode.system);

    await cubit.changeLanguage('ar');
    await cubit.changeThemeMode(ThemeMode.dark);
    expect(cubit.state.locale, const Locale('ar'));
    expect(cubit.state.themeMode, ThemeMode.dark);

    final restored = AppSettingsCubit();
    expect(restored.state.locale, const Locale('ar'));
    expect(restored.state.themeMode, ThemeMode.dark);
  });

  test('plural messages', () {
    final ar = lookupAppLocalizations(const Locale('ar'));
    final en = lookupAppLocalizations(const Locale('en'));
    expect(ar.itemsCount(1), 'عنصر واحد');
    expect(ar.itemsCount(3), '3 عناصر');
    expect(en.itemsCount(1), '1 item');
    expect(en.itemsCount(2), '2 items');
  });

  testWidgets('bottom nav is translated and right-to-left in Arabic', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('ar'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        theme: AppTheme.themeLight,
        darkTheme: AppTheme.themeDark,
        themeMode: ThemeMode.dark,
        home: Scaffold(
          bottomNavigationBar: AdminBottomNavBar(
            selectedIndex: 0,
            onTabChange: (_) {},
          ),
        ),
      ),
    );

    expect(find.text('الرئيسية'), findsOneWidget);
    expect(find.text('المزيد'), findsOneWidget);
    expect(
      tester.getCenter(find.text('الرئيسية')).dx,
      greaterThan(tester.getCenter(find.text('المزيد')).dx),
    );
  });

  testWidgets('snack bar text stays white on brand green in dark mode', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.themeLight,
        darkTheme: AppTheme.themeDark,
        themeMode: ThemeMode.dark,
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Saved'),
                  backgroundColor: AppColors.primaryColor,
                ),
              ),
              child: const Text('show'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('show'));
    await tester.pump();

    final style = tester
        .widget<DefaultTextStyle>(
          find
              .ancestor(
                of: find.text('Saved'),
                matching: find.byType(DefaultTextStyle),
              )
              .first,
        )
        .style;
    expect(style.color, AppColors.onPrimary);
  });
}
