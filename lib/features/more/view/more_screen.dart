import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_admin/core/local/local_storage.dart';
import 'package:shoply_admin/core/local/local_storage_user.dart';
import 'package:shoply_admin/core/routes/app_pages.dart';
import 'package:shoply_admin/core/utils/l10n/app_l10n.dart';
import 'package:shoply_admin/core/utils/theme/app_colors.dart';
import 'package:shoply_admin/core/utils/widgets/dialog/app_confirmation_dialog.dart';
import 'package:shoply_admin/features/about/view/about_screen.dart';
import 'package:shoply_admin/features/app/view_model/cubit.dart';
import 'package:shoply_admin/features/contact/view/contact_us_screen.dart';
import 'package:shoply_admin/features/help/view/help_center_screen.dart';
import 'package:shoply_admin/features/notifications/view/notifications_screen.dart';
import 'package:shoply_admin/features/store_settings/view/payment_methods_screen.dart';
import 'package:shoply_admin/features/store_settings/view/shipping_settings_screen.dart';
import 'package:shoply_admin/features/store_settings/view/store_settings_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  // ================= LOGOUT =================

  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();

      await LocalStorage.instance.setIsLogin(isLogin: false);

      await LocalStorageUser.instance.clearUserData();

      if (!context.mounted) return;

      Navigator.pushNamedAndRemoveUntil(
        context,
        AppPages.loginScreen,
        (route) => false,
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.logoutFailed('$e'))));
    }
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final l10n = context.l10n;
    final confirmed = await AppConfirmationDialog.show(
      context: context,
      title: l10n.logoutTitle,
      message: l10n.logoutMessage,
      confirmText: l10n.logoutConfirm,
      cancelText: l10n.logoutCancel,
      icon: Icons.logout_rounded,
      isDangerous: true,
    );

    if (!confirmed || !context.mounted) return;

    await _logout(context);
  }

  // ================= NAVIGATION =================

  void _openPage(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  // ================= LANGUAGE & APPEARANCE =================

  Map<String, String> _languages(AppLocalizations l10n) => {
    'en': l10n.languageEnglish,
    'ar': l10n.languageArabic,
  };

  Map<ThemeMode, String> _themeModes(AppLocalizations l10n) => {
    ThemeMode.light: l10n.themeLight,
    ThemeMode.dark: l10n.themeDark,
    ThemeMode.system: l10n.themeSystem,
  };

  // same look as the sort and order status sheets
  Future<T?> _showOptionsSheet<T>({
    required BuildContext context,
    required String title,
    required Map<T, String> options,
    required T selected,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        final primary = Theme.of(context).colorScheme.primary;
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                for (final option in options.entries)
                  ListTile(
                    leading: Icon(
                      option.key == selected
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      color: primary,
                    ),
                    title: Text(
                      option.value,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    onTap: () => Navigator.pop(context, option.key),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _chooseLanguage(BuildContext context) async {
    final cubit = context.read<AppSettingsCubit>();
    final languageCode = await _showOptionsSheet(
      context: context,
      title: context.l10n.language,
      options: _languages(context.l10n),
      selected: cubit.state.locale.languageCode,
    );
    if (languageCode != null) await cubit.changeLanguage(languageCode);
  }

  Future<void> _chooseAppearance(BuildContext context) async {
    final cubit = context.read<AppSettingsCubit>();
    final themeMode = await _showOptionsSheet(
      context: context,
      title: context.l10n.appearance,
      options: _themeModes(context.l10n),
      selected: cubit.state.themeMode,
    );
    if (themeMode != null) await cubit.changeThemeMode(themeMode);
  }

  // ================= MENU ITEM =================

  Widget _item({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required int animationIndex,
    String? subtitle,
    Color? color,
  }) {
    final theme = Theme.of(context);
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    // slide in from the start edge (right side in Arabic)
    final slideBegin = Directionality.of(context) == TextDirection.rtl
        ? 0.10
        : -0.10;

    final itemColor = color ?? theme.colorScheme.onSurface;

    final tile = ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: itemColor),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: itemColor,
        ),
      ),
      subtitle: subtitle == null
          ? null
          : Text(
              subtitle,
              style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
            ),
      trailing: color == null
          ? Icon(Icons.chevron_right, color: theme.colorScheme.onSurfaceVariant)
          : null,
      onTap: onTap,
    );

    if (reduceMotion) return tile;

    return tile
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 70 * animationIndex),
          duration: 320.ms,
          curve: Curves.easeOut,
        )
        .slideX(
          begin: slideBegin,
          end: 0,
          delay: Duration(milliseconds: 70 * animationIndex),
          duration: 320.ms,
          curve: Curves.easeOutCubic,
        );
  }

  // ================= BUILD =================

  @override
  Widget build(BuildContext context) {
    final user = LocalStorageUser.instance;
    final theme = Theme.of(context);
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final l10n = context.l10n;
    final settings = context.watch<AppSettingsCubit>().state;

    final heading = Text(
      l10n.more,
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.onSurface,
      ),
    );

    final profileCard = Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: theme.colorScheme.primaryContainer,
            backgroundImage: user.profileImage.isEmpty
                ? null
                : NetworkImage(user.profileImage),
            child: user.profileImage.isEmpty
                ? Icon(
                    Icons.person,
                    color: theme.colorScheme.onPrimaryContainer,
                    size: 30,
                  )
                : null,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.fullName.isEmpty ? l10n.admin : user.fullName,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                Text(
                  l10n.storeOwner,
                  style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
                ),
                Text(
                  user.email,
                  style: TextStyle(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          reduceMotion
              ? heading
              : heading
                    .animate()
                    .fadeIn(duration: 350.ms)
                    .slideY(begin: -0.15, end: 0, duration: 350.ms),

          const SizedBox(height: 16),

          reduceMotion
              ? profileCard
              : profileCard
                    .animate()
                    .fadeIn(delay: 80.ms, duration: 400.ms)
                    .slideY(
                      begin: 0.12,
                      end: 0,
                      delay: 80.ms,
                      duration: 400.ms,
                    ),

          const SizedBox(height: 16),

          // STORE SETTINGS
          _item(
            context: context,
            icon: Icons.storefront_outlined,
            title: l10n.storeSettings,
            animationIndex: 0,
            onTap: () => _openPage(context, const StoreSettingsScreen()),
          ),

          _item(
            context: context,
            icon: Icons.credit_card_outlined,
            title: l10n.paymentMethods,
            animationIndex: 1,
            onTap: () => _openPage(context, const PaymentMethodsScreen()),
          ),

          _item(
            context: context,
            icon: Icons.local_shipping_outlined,
            title: l10n.shippingSettings,
            animationIndex: 2,
            onTap: () => _openPage(context, const ShippingSettingsScreen()),
          ),

          _item(
            context: context,
            icon: Icons.notifications_none,
            title: l10n.notifications,
            animationIndex: 3,
            onTap: () => _openPage(context, const NotificationsScreen()),
          ),

          // PREFERENCES
          _item(
            context: context,
            icon: Icons.language_outlined,
            title: l10n.language,
            subtitle: _languages(l10n)[settings.locale.languageCode],
            animationIndex: 4,
            onTap: () => _chooseLanguage(context),
          ),

          _item(
            context: context,
            icon: Icons.dark_mode_outlined,
            title: l10n.appearance,
            subtitle: _themeModes(l10n)[settings.themeMode],
            animationIndex: 5,
            onTap: () => _chooseAppearance(context),
          ),

          Divider(color: theme.colorScheme.outlineVariant),

          // SUPPORT
          _item(
            context: context,
            icon: Icons.help_outline,
            title: l10n.helpCenter,
            animationIndex: 6,
            onTap: () => _openPage(context, const HelpCenterScreen()),
          ),

          _item(
            context: context,
            icon: Icons.mail_outline,
            title: l10n.contactUs,
            animationIndex: 7,
            onTap: () => _openPage(context, const ContactUsScreen()),
          ),

          _item(
            context: context,
            icon: Icons.info_outline,
            title: l10n.aboutApp,
            animationIndex: 8,
            onTap: () => _openPage(context, const AboutScreen()),
          ),

          Divider(color: theme.colorScheme.outlineVariant),

          // LOGOUT
          _item(
            context: context,
            icon: Icons.logout_rounded,
            title: l10n.logOut,
            color: AppColors.cancelled,
            animationIndex: 9,
            onTap: () => _confirmLogout(context),
          ),
        ],
      ),
    );
  }
}
