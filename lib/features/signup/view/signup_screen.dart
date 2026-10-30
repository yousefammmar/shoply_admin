import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_admin/core/regex/app_regex.dart';
import 'package:shoply_admin/core/routes/app_pages.dart';
import 'package:shoply_admin/core/utils/images/app_images.dart';
import 'package:shoply_admin/core/utils/theme/app_colors.dart';
import 'package:shoply_admin/core/utils/widgets/button/custom_button.dart';
import 'package:shoply_admin/core/utils/widgets/button/custom_google_button.dart';
import 'package:shoply_admin/core/utils/widgets/dialog/custom_dialog_error.dart';
import 'package:shoply_admin/core/utils/widgets/dialog/custom_success_dialog.dart';
import 'package:shoply_admin/core/utils/widgets/divider/custom_or_divider.dart';
import 'package:shoply_admin/core/utils/widgets/loading/custom_loading.dart';
import 'package:shoply_admin/core/utils/widgets/text_button/custom_text_button_wrap.dart';
import 'package:shoply_admin/core/utils/widgets/textfield/custom_text_field.dart';
import 'package:shoply_admin/features/signup/view_model/cubit.dart';
import 'package:shoply_admin/features/signup/view_model/state.dart';
import 'package:shoply_admin/core/utils/l10n/app_l10n.dart';
part 'widgets/signup_header.dart';
part 'widgets/signup_textfields.dart';
part 'widgets/signup_bottom.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: Scaffold(
        body: BlocListener<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state is SignupLoadingState) {
              CustomLoading.showDialogLoading(context: context);
            } else if (state is SignupErrorState) {
              Navigator.pop(context);
              CustomDialogError.showProDialogError(
                context: context,
                title: context.l10n.signupError,
                description: state.errorMessage,
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            } else if (state is SignupSuccessState) {
              Navigator.pop(context);
              CustomSuccessDialog.showProSuccessDialog(
                context: context,
                title: context.l10n.requestSent,
                description: state.successMessage,
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppPages.loginScreen,
                    (route) => false,
                  );
                },
              );
            } else if (state is SignupGoogleSuccessState) {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppPages.homeScreen,
                (route) => false,
              );
            }
          },
          child: Builder(
            builder: (context) {
              final cubit = context.read<SignupCubit>();
              return SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Center(
                      child: Form(
                        key: cubit.formKey,
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            _SignupHeader(),
                            SizedBox(height: 25),
                            _SignupTextfields(),
                            SizedBox(height: 10),
                            _SignupBottom(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
