part of '../login_screen.dart';

class _LoginHeader extends StatelessWidget {
  const _LoginHeader();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final l10n = context.l10n;
    return Column(
      children: [
        Image(
          image: NetworkImage(AppImages.splash),
          height: 130,
          width: 160,
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
        SizedBox(height: 25),
        Text(
          l10n.welcomeBack,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            color: colors.onSurface,
          ),
        ),
        Text(
          l10n.signInSubtitle,
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
