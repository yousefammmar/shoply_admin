import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_admin/core/utils/theme/app_colors.dart';
import 'package:shoply_admin/core/utils/widgets/button/custom_button.dart';
import 'package:shoply_admin/core/utils/widgets/dialog/custom_dialog_error.dart';
import 'package:shoply_admin/core/utils/widgets/dialog/custom_success_dialog.dart';
import 'package:shoply_admin/core/utils/widgets/loading/custom_loading.dart';
import 'package:shoply_admin/features/store_settings/view_model/cubit.dart';
import 'package:shoply_admin/features/store_settings/view_model/state.dart';
import 'package:shoply_admin/core/utils/l10n/app_l10n.dart';

// Loads the settings, shows the fields of one screen and a Save button
class StoreSettingsPage extends StatelessWidget {
  final String title;
  final List<Widget> Function(StoreSettingsCubit cubit) fieldsBuilder;

  const StoreSettingsPage({
    super.key,
    required this.title,
    required this.fieldsBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoreSettingsCubit()..loadSettings(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          elevation: 0,
        ),
        body: BlocConsumer<StoreSettingsCubit, StoreSettingsState>(
          listener: (context, state) {
            if (state is StoreSettingsLoadingState) {
              CustomLoading.showDialogLoading(context: context);
            } else if (state is StoreSettingsErrorState) {
              Navigator.pop(context);
              CustomDialogError.showProDialogError(
                context: context,
                title: context.l10n.saveError,
                description: state.errorMessage,
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            } else if (state is StoreSettingsSuccessState) {
              Navigator.pop(context);
              CustomSuccessDialog.showProSuccessDialog(
                context: context,
                title: context.l10n.saved,
                description: state.successMessage,
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<StoreSettingsCubit>();

            if (state is StoreSettingsLoadErrorState) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    context.l10n.failedLoadSettings(state.errorMessage),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            if (state is StoreSettingsInitState) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: cubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...fieldsBuilder(cubit),
                    SizedBox(height: 10),
                    CustomButton(
                      buttonText: context.l10n.save,
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.onPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                      onPressed: () {
                        cubit.saveSettings();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SettingsLabel extends StatelessWidget {
  final String text;

  const SettingsLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
