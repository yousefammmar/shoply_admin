import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_admin/core/model/settings/store_settings_model.dart';
import 'package:shoply_admin/features/store_settings/repo/store_settings_repo.dart';
import 'package:shoply_admin/features/store_settings/view_model/state.dart';
import 'package:shoply_admin/core/utils/l10n/app_l10n.dart';

// Shared by the store, shipping and payment screens.
// Each screen edits its own fields and saves the whole document.
class StoreSettingsCubit extends Cubit<StoreSettingsState> {
  StoreSettingsCubit() : super(StoreSettingsInitState());

  static const allPaymentMethods = [
    'Cash on delivery',
    'Credit / debit card',
    'Mobile wallet',
  ];

  final _storeSettingsRepo = StoreSettingsRepo();
  final storeNameController = TextEditingController();
  final contactEmailController = TextEditingController();
  final contactPhoneController = TextEditingController();
  final addressController = TextEditingController();
  final shippingFeeController = TextEditingController();
  final freeShippingOverController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  List<String> paymentMethods = [];

  Future<void> loadSettings() async {
    final result = await _storeSettingsRepo.getSettings();
    result.fold(
      (errorMessage) {
        emit(StoreSettingsLoadErrorState(errorMessage: errorMessage));
      },
      (settings) {
        storeNameController.text = settings.storeName;
        contactEmailController.text = settings.contactEmail;
        contactPhoneController.text = settings.contactPhone;
        addressController.text = settings.address;
        shippingFeeController.text = settings.shippingFee.toStringAsFixed(2);
        freeShippingOverController.text = settings.freeShippingOver
            .toStringAsFixed(2);
        paymentMethods = settings.paymentMethods;
        emit(StoreSettingsLoadedState());
      },
    );
  }

  void togglePaymentMethod(String method) {
    if (paymentMethods.contains(method)) {
      paymentMethods.remove(method);
    } else {
      paymentMethods.add(method);
    }
    emit(StoreSettingsChangedState());
  }

  Future<void> saveSettings() async {
    if (formKey.currentState?.validate() ?? true) {
      emit(StoreSettingsLoadingState());
      final result = await _storeSettingsRepo.saveSettings(
        StoreSettingsModel(
          storeName: storeNameController.text.trim(),
          contactEmail: contactEmailController.text.trim(),
          contactPhone: contactPhoneController.text.trim(),
          address: addressController.text.trim(),
          shippingFee: double.tryParse(shippingFeeController.text) ?? 0,
          freeShippingOver:
              double.tryParse(freeShippingOverController.text) ?? 0,
          paymentMethods: paymentMethods,
        ),
      );
      result.fold(
        (errorMessage) {
          emit(StoreSettingsErrorState(errorMessage: errorMessage));
        },
        (_) {
          emit(
            StoreSettingsSuccessState(successMessage: appL10n.settingsSaved),
          );
        },
      );
    }
  }

  @override
  Future<void> close() {
    storeNameController.dispose();
    contactEmailController.dispose();
    contactPhoneController.dispose();
    addressController.dispose();
    shippingFeeController.dispose();
    freeShippingOverController.dispose();
    return super.close();
  }
}
