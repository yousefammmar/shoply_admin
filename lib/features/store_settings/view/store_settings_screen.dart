import 'package:flutter/material.dart';
import 'package:shoply_admin/core/regex/app_regex.dart';
import 'package:shoply_admin/core/utils/widgets/textfield/custom_text_field.dart';
import 'package:shoply_admin/features/store_settings/view/widgets/store_settings_page.dart';
import 'package:shoply_admin/core/utils/l10n/app_l10n.dart';

class StoreSettingsScreen extends StatelessWidget {
  const StoreSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return StoreSettingsPage(
      title: l10n.storeSettings,
      fieldsBuilder: (cubit) => [
        SettingsLabel(l10n.storeName),
        CustomTextField(
          validator: (name) {
            if (name?.trim().isEmpty ?? true) {
              return l10n.storeNameRequired;
            }
            return null;
          },
          controller: cubit.storeNameController,
          hinText: 'Shoply',
        ),
        SettingsLabel(l10n.contactEmail),
        CustomTextField(
          validator: (email) {
            if ((email?.isNotEmpty ?? false) &&
                AppRegex.emailRegex.hasMatch(email!) == false) {
              return l10n.emailInvalid;
            }
            return null;
          },
          controller: cubit.contactEmailController,
          hinText: 'store@example.com',
          keyboardType: TextInputType.emailAddress,
        ),
        SettingsLabel(l10n.contactPhone),
        CustomTextField(
          controller: cubit.contactPhoneController,
          hinText: '+962 7X XXX XXXX',
          keyboardType: TextInputType.phone,
        ),
        SettingsLabel(l10n.address),
        CustomTextField(
          controller: cubit.addressController,
          hinText: l10n.addressHint,
          maxLines: 2,
        ),
      ],
    );
  }
}
