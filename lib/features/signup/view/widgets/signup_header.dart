part of '../signup_screen.dart';

class _SignupHeader extends StatelessWidget {
  const _SignupHeader();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final l10n = context.l10n;
    return Column(
      children: [
        Image(
          image: NetworkImage(AppImages.splash),
          height: 110,
          width: 135,
          fit: BoxFit.cover,
        ),
        Text(
          l10n.sellerApp,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: colors.onSurfaceVariant,
          ),
        ),
        SizedBox(height: 20),
        Text(
          l10n.createAccount,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: colors.onSurface,
          ),
        ),
        Text(
          l10n.signupSubtitle,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
