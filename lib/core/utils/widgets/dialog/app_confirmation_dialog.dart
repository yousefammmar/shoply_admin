import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shoply_admin/core/utils/l10n/app_l10n.dart';
import 'package:shoply_admin/core/utils/theme/app_colors.dart';

class AppConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  // null uses the localized "Confirm" / "Cancel"
  final String? confirmText;
  final String? cancelText;
  final IconData icon;
  final bool isDangerous;

  const AppConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmText,
    this.cancelText,
    this.icon = Icons.help_outline_rounded,
    this.isDangerous = false,
  });

  static Future<bool> show({
    required BuildContext context,
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    IconData icon = Icons.help_outline_rounded,
    bool isDangerous = false,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => AppConfirmationDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        icon: icon,
        isDangerous: isDangerous,
      ),
    );

    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    final colors = Theme.of(context).colorScheme;

    // icon accent follows the theme, the filled button keeps the brand green
    final accentColor = isDangerous ? AppColors.cancelled : colors.primary;
    final actionColor = isDangerous
        ? AppColors.cancelled
        : AppColors.primaryColor;

    Widget content = Dialog(
      backgroundColor: colors.surfaceContainerHigh,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 38,
              backgroundColor: accentColor.withValues(alpha: 0.10),
              child: Icon(icon, color: accentColor, size: 38),
            ),

            const SizedBox(height: 20),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 1.6,
                color: colors.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 26),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 13),
                    ),
                    child: Text(cancelText ?? context.l10n.cancel),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: actionColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 13),
                    ),
                    child: Text(confirmText ?? context.l10n.confirm),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    if (!reduceMotion) {
      content = content
          .animate()
          .fadeIn(duration: 220.ms)
          .scale(
            begin: const Offset(0.88, 0.88),
            end: const Offset(1, 1),
            duration: 350.ms,
            curve: Curves.easeOutBack,
          );
    }

    return content;
  }
}
