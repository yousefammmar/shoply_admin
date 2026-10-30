
part of '../login_screen.dart';

class _LoginBottom extends StatelessWidget {
  const _LoginBottom();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        CustomTextButtonWrap(
          text: 'Don\'t have an account?',
          textClick: ' Sign Up',
          onTap: () {
            Navigator.pushNamed(
              context,
              AppPages.signupScreen,
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
