import 'package:flutter/material.dart';
import 'package:shoply_admin/core/utils/l10n/app_l10n.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  static Map<String, String> questions(AppLocalizations l10n) => {
    l10n.helpQ1: l10n.helpA1,
    l10n.helpQ2: l10n.helpA2,
    l10n.helpQ3: l10n.helpA3,
    l10n.helpQ4: l10n.helpA4,
    l10n.helpQ5: l10n.helpA5,
  };

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.helpCenter,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (final question in questions(l10n).entries)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colors.outlineVariant),
                ),
                child: ExpansionTile(
                  shape: Border(),
                  iconColor: colors.primary,
                  title: Text(
                    question.key,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  children: [
                    Text(
                      question.value,
                      style: TextStyle(
                        color: colors.onSurfaceVariant,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
