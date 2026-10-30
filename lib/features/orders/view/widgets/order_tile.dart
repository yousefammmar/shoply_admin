import 'package:flutter/material.dart';
import 'package:shoply_admin/core/model/order/order_model.dart';
import 'package:shoply_admin/core/utils/theme/app_colors.dart';
import 'package:shoply_admin/core/utils/widgets/cached_image_network/custom_cached_image_network.dart';
import 'package:shoply_admin/features/orders/view/widgets/order_status_badge.dart';
import 'package:shoply_admin/core/utils/l10n/app_l10n.dart';

class OrderTile extends StatelessWidget {
  final OrderModel order;
  final VoidCallback? onTap;

  const OrderTile({super.key, required this.order, this.onTap});

  @override
  Widget build(BuildContext context) {
    final image = order.items.isNotEmpty ? order.items.first.image : '';
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.outlineVariant),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 48,
                height: 48,
                child: image.isEmpty
                    ? Container(
                        color: AppColors.pending.withValues(alpha: 0.12),
                        child: Icon(
                          Icons.shopping_bag_outlined,
                          color: AppColors.pending,
                        ),
                      )
                    : CustomCachedImageNetwork(image: image),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.orderNumber,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 2),
                  Text(
                    context.l10n.itemsCount(order.itemsCount),
                    style: TextStyle(
                      color: colors.onSurfaceVariant,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '\$${order.total.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 10),
            OrderStatusBadge(status: order.status),
          ],
        ),
      ),
    );
  }
}
