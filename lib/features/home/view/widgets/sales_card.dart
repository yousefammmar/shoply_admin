import 'package:flutter/material.dart';
import 'package:shoply_admin/core/utils/theme/app_colors.dart';
import 'package:shoply_admin/core/utils/l10n/app_l10n.dart';

class SalesCard extends StatelessWidget {
  final double totalSales;
  final double? salesChange;
  final String selectedPeriod;
  final void Function(String) onPeriodChanged;

  const SalesCard({
    super.key,
    required this.totalSales,
    required this.salesChange,
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  static Map<String, String> periods(AppLocalizations l10n) => {
    'today': l10n.today,
    'week': l10n.thisWeek,
    'month': l10n.thisMonth,
    'all': l10n.allTime,
  };

  @override
  Widget build(BuildContext context) {
    final change = salesChange;
    final l10n = context.l10n;
    final periodLabels = periods(l10n);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.totalSales,
                  style: TextStyle(
                    color: AppColors.onPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              PopupMenuButton<String>(
                onSelected: onPeriodChanged,
                itemBuilder: (_) => [
                  for (final period in periodLabels.entries)
                    PopupMenuItem(value: period.key, child: Text(period.value)),
                ],
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.onPrimary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        periodLabels[selectedPeriod]!,
                        style: TextStyle(
                          color: AppColors.onPrimary,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.onPrimary,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  '\$${totalSales.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: AppColors.onPrimary,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (change != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.onPrimary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${change >= 0 ? '+' : ''}${change.toStringAsFixed(0)}%',
                    style: TextStyle(
                      color: AppColors.onPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
