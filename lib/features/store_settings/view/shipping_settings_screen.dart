import 'package:flutter/material.dart';
import 'package:shoply_admin/core/utils/widgets/textfield/custom_text_field.dart';
import 'package:shoply_admin/features/store_settings/view/widgets/store_settings_page.dart';
import 'package:shoply_admin/core/utils/l10n/app_l10n.dart';

class ShippingSettingsScreen extends StatelessWidget {
  const ShippingSettingsScreen({super.key});

  String? _validateAmount(AppLocalizations l10n, String? amount) {
    final value = double.tryParse(amount ?? '');
    if (amount?.isEmpty ?? true) {
      return l10n.amountRequired;
    } else if (value == null || value < 0) {
      return l10n.amountInvalid;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return StoreSettingsPage(
      title: l10n.shippingSettings,
      fieldsBuilder: (cubit) => [
        SettingsLabel(l10n.shippingFee),
        CustomTextField(
          validator: (amount) => _validateAmount(l10n, amount),
          controller: cubit.shippingFeeController,
          hinText: '0.00',
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          prefixIcon: Icon(Icons.attach_money),
        ),
        SettingsLabel(l10n.freeShippingOver),
        CustomTextField(
          validator: (amount) => _validateAmount(l10n, amount),
          controller: cubit.freeShippingOverController,
          hinText: '0.00',
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          prefixIcon: Icon(Icons.attach_money),
        ),
        Text(
          l10n.freeShippingHint,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
