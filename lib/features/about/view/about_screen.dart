import 'package:flutter/material.dart';
import 'package:shoply_admin/core/utils/l10n/app_l10n.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.aboutApp,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        foregroundColor: colors.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 30),

            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: colors.primaryContainer,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Icon(
                Icons.storefront_outlined,
                size: 65,
                color: colors.onPrimaryContainer,
              ),
            ),

            const SizedBox(height: 24),

            Text(
              l10n.appTitle,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: colors.primary,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              l10n.appVersion('1.0.0'),
              style: TextStyle(fontSize: 15, color: colors.onSurfaceVariant),
            ),

            const SizedBox(height: 32),

            Text(
              l10n.aboutTheApplication,
              style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            Text(
              l10n.aboutDescription,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                height: 1.7,
                color: colors.onSurface.withValues(alpha: 0.87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
