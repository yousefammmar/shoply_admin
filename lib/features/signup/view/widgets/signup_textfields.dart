part of '../signup_screen.dart';

class _SignupTextfields extends StatelessWidget {
  const _SignupTextfields();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();
    final l10n = context.l10n;

    return Column(
      children: [
        CustomTextField(
          validator: (name) {
            if (name?.isEmpty ?? false) {
              return l10n.fullNameRequired;
            }
            return null;
          },
          controller: cubit.fullNameController,
          hinText: l10n.fullName,
          prefixIcon: Icon(Icons.person_outline, size: 26),
        ),
        SizedBox(height: 5),
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
          prefixIcon: Icon(Icons.email_outlined, size: 26),
        ),
        SizedBox(height: 5),
        CustomTextField(
          validator: (password) {
            if (password?.isEmpty ?? false) {
              return l10n.passwordRequired;
            } else if (password!.length < 6) {
              return l10n.passwordTooShort;
            } else if (AppRegex.passwordRegex.hasMatch(password) == false) {
              return l10n.passwordWeak;
            }
            return null;
          },
          obscureText: true,
          controller: cubit.passwordController,
          hinText: l10n.password,
          prefixIcon: Icon(Icons.lock_outline, size: 26),
        ),
        SizedBox(height: 5),
        CustomTextField(
          validator: (confirmPassword) {
            if (confirmPassword?.isEmpty ?? false) {
              return l10n.confirmPasswordRequired;
            } else if (confirmPassword != cubit.passwordController.text) {
              return l10n.passwordsDoNotMatch;
            }
            return null;
          },
          obscureText: true,
          controller: cubit.confirmPasswordController,
          hinText: l10n.confirmPassword,
          prefixIcon: Icon(Icons.lock_outline, size: 26),
        ),
      ],
    );
  }
}
