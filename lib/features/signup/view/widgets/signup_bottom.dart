part of '../signup_screen.dart';

class _SignupBottom extends StatelessWidget {
  const _SignupBottom();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();
    final l10n = context.l10n;
    return Column(
      children: [
        CustomButton(
          buttonText: l10n.signUp,
          style: TextStyle(
            fontSize: 22,
            color: AppColors.onPrimary,
            fontWeight: FontWeight.w700,
          ),
          onPressed: () {
            cubit.signup();
          },
        ),
        SizedBox(height: 25),
        CustomOrDivider(),
        SizedBox(height: 20),
        CustomGoogleButton(
          buttonText: l10n.signUpWithGoogle,
          onPressed: () {
            cubit.signupWithGoogle();
          },
        ),
        SizedBox(height: 25),
        CustomTextButtonWrap(
          text: l10n.alreadyHaveAccount,
          textClick: ' ${l10n.logIn}',
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppPages.loginScreen,
              (route) => false,
            );
          },
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
