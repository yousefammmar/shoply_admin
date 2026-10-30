import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_admin/features/store_settings/view/widgets/store_settings_page.dart';
import 'package:shoply_admin/features/store_settings/view_model/cubit.dart';
import 'package:shoply_admin/features/store_settings/view_model/state.dart';
import 'package:shoply_admin/core/utils/l10n/app_l10n.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  // methods are saved in English in Firestore (the shopping app reads them),
  // only the label shown here is translated
  String _methodLabel(AppLocalizations l10n, String method) {
    switch (method) {
      case 'Cash on delivery':
        return l10n.paymentCash;
      case 'Credit / debit card':
        return l10n.paymentCard;
      case 'Mobile wallet':
        return l10n.paymentWallet;
      default:
        return method;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return StoreSettingsPage(
      title: l10n.paymentMethods,
      fieldsBuilder: (cubit) => [
        Text(
          l10n.paymentMethodsDescription,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontSize: 15,
          ),
        ),
        SizedBox(height: 10),
        BlocBuilder<StoreSettingsCubit, StoreSettingsState>(
          builder: (context, state) {
            return Column(
              children: [
                for (final method in StoreSettingsCubit.allPaymentMethods)
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    value: cubit.paymentMethods.contains(method),
                    title: Text(
                      _methodLabel(l10n, method),
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    onChanged: (_) => cubit.togglePaymentMethod(method),
                  ),
              ],
            );
          },
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
