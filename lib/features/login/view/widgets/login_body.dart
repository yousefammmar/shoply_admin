part of '../login_screen.dart';

class _LoginBody extends StatelessWidget {
  const _LoginBody();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    final l10n = context.l10n;

    return Column(
      children: [
        CustomTextField(
          validator: (email) {
            if (email?.isEmpty ?? false) {
              return l10n.emailRequired;
            } else if (AppRegex.emailRegex.hasMatch(email ?? '') == false) {
              return l10n.emailInvalid;
            }
            return null;
          },
          controller: cubit.emailController,
          hinText: l10n.email,
          prefixIcon: Icon(Icons.person_outline, size: 26),
        ),
        SizedBox(height: 10),
        CustomTextField(
          validator: (password) {
            if (password?.isEmpty ?? false) {
              return l10n.passwordRequired;
            }
            return null;
          },
          obscureText: true,
          controller: cubit.passwordController,
          hinText: l10n.password,
          prefixIcon: Icon(Icons.lock_outline, size: 26),
        ),
        SizedBox(height: 10),
        CustomButton(
          buttonText: l10n.logIn,
          style: TextStyle(
            fontSize: 22,
            color: AppColors.onPrimary,
            fontWeight: FontWeight.w700,
          ),
          onPressed: () {
            cubit.login();
          },
        ),
        SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppPages.forgotPasswordScreen);
          },
          child: Text(
            l10n.forgotPassword,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
