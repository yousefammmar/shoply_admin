import 'package:flutter/material.dart';
import 'package:pro_dialog/pro_dialog.dart';
import 'package:shoply_admin/core/utils/l10n/app_l10n.dart';

class CustomSuccessDialog extends StatelessWidget {
  const CustomSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  static void showProSuccessDialog({
    required BuildContext context,
    required String title,
    required String description,
    required void Function() onPressed,
  }) {
    showProDialog(
      context,
      type: DialogType.success,
      title: title,
      description: description,
      buttons: [
        DialogButton(
          text: context.l10n.gotIt,
          isPrimary: true,
          onPressed: onPressed,
        ),
      ],
    );
  }
}
