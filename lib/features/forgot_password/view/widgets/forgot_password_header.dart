part of '../forgot_password_screen.dart';

class _ForgotPasswordHeader extends StatelessWidget {
  const _ForgotPasswordHeader();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      children: [
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colors.primary.withValues(alpha: 0.15),
          ),
          child: Icon(Icons.lock, size: 70, color: colors.primary),
        ),
        SizedBox(height: 20),
        Text(
          context.l10n.forgotPassword,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: colors.onSurface,
          ),
        ),
        SizedBox(height: 15),
        Text(
          context.l10n.forgotPasswordSubtitle,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: colors.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
