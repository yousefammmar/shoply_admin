part of '../login_screen.dart';

class _LoginBottom extends StatelessWidget {
  const _LoginBottom();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    final l10n = context.l10n;
    return Column(
      children: [
        CustomOrDivider(),
        SizedBox(height: 20),
        CustomGoogleButton(
          buttonText: l10n.signInWithGoogle,
          onPressed: () {
            cubit.loginWithGoogle();
          },
        ),
        SizedBox(height: 30),
        CustomTextButtonWrap(
          text: l10n.dontHaveAccount,
          textClick: ' ${l10n.signUp}',
          onTap: () {
            Navigator.pushNamed(context, AppPages.signupScreen);
          },
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
