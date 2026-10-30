import 'package:flutter/material.dart';
import 'package:shoply_admin/core/utils/theme/app_colors.dart';

// Tabs like "All (24)  Active (20)  Inactive (4)"
class CustomFilterChips extends StatelessWidget {
  const CustomFilterChips({
    super.key,
    required this.filters,
    required this.labels,
    required this.counts,
    required this.selectedFilter,
    required this.onSelected,
  });
  final List<String> filters;
  final List<String> labels;
  final List<int> counts;
  final String selectedFilter;
  final void Function(String) onSelected;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, _) => SizedBox(width: 8),
        itemBuilder: (context, index) {
          final selected = filters[index] == selectedFilter;
          return GestureDetector(
            onTap: () => onSelected(filters[index]),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? AppColors.primaryColor : colors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: selected
                      ? AppColors.primaryColor
                      : colors.outlineVariant,
                ),
              ),
              child: Text(
                '${labels[index]} (${counts[index]})',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: selected
                      ? AppColors.onPrimary
                      : colors.onSurfaceVariant,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
