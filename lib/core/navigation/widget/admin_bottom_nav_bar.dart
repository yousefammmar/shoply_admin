import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoply_admin/core/utils/l10n/app_l10n.dart';

class AdminBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabChange;

  const AdminBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
  });

  static const Duration _duration = Duration(milliseconds: 300);

  Widget _buildItem({
    required BuildContext context,
    required int index,
    required IconData icon,
    required IconData selectedIcon,
    required String text,
  }) {
    final bool selected = selectedIndex == index;
    final bool reduceMotion = MediaQuery.disableAnimationsOf(context);

    final Duration duration = reduceMotion ? Duration.zero : _duration;

    final Color activeColor = Theme.of(context).colorScheme.primary;
    final Color inactiveColor = Theme.of(context).colorScheme.onSurfaceVariant;

    return Expanded(
      child: Semantics(
        button: true,
        selected: selected,
        label: text,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            if (!selected) {
              if (!reduceMotion) {
                HapticFeedback.selectionClick();
              }
              onTabChange(index);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
            child: AnimatedContainer(
              duration: duration,
              curve: Curves.easeOutCubic,
              decoration: BoxDecoration(
                color: selected
                    ? activeColor.withValues(alpha: 0.09)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedScale(
                    scale: selected ? 1.13 : 1.0,
                    duration: duration,
                    curve: Curves.easeOutBack,
                    child: AnimatedSwitcher(
                      duration: duration,
                      switchInCurve: Curves.easeOutCubic,
                      switchOutCurve: Curves.easeInCubic,
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: ScaleTransition(
                            scale: animation,
                            child: child,
                          ),
                        );
                      },
                      child: Icon(
                        selected ? selectedIcon : icon,
                        key: ValueKey(selected),
                        size: 24,
                        color: selected ? activeColor : inactiveColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  AnimatedDefaultTextStyle(
                    duration: duration,
                    curve: Curves.easeOut,
                    style: TextStyle(
                      color: selected ? activeColor : inactiveColor,
                      fontSize: 12,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                    ),
                    child: Text(
                      text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color surfaceColor = Theme.of(context).colorScheme.surface;
    final l10n = context.l10n;

    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 66,
          child: Row(
            children: [
              _buildItem(
                context: context,
                index: 0,
                icon: Icons.home_outlined,
                selectedIcon: Icons.home_rounded,
                text: l10n.home,
              ),
              _buildItem(
                context: context,
                index: 1,
                icon: Icons.inventory_2_outlined,
                selectedIcon: Icons.inventory_2_rounded,
                text: l10n.products,
              ),
              _buildItem(
                context: context,
                index: 2,
                icon: Icons.receipt_long_outlined,
                selectedIcon: Icons.receipt_long_rounded,
                text: l10n.orders,
              ),
              _buildItem(
                context: context,
                index: 3,
                icon: Icons.menu_outlined,
                selectedIcon: Icons.menu_rounded,
                text: l10n.more,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
