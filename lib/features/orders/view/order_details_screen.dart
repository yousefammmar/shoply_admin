import 'package:flutter/material.dart';
import 'package:shoply_admin/core/model/customer/customer_model.dart';
import 'package:shoply_admin/core/model/order/order_model.dart';
import 'package:shoply_admin/core/utils/theme/app_colors.dart';
import 'package:shoply_admin/core/utils/widgets/button/custom_button.dart';
import 'package:shoply_admin/core/utils/widgets/cached_image_network/custom_cached_image_network.dart';
import 'package:shoply_admin/core/utils/widgets/dialog/app_confirmation_dialog.dart';
import 'package:shoply_admin/features/customers/repo/customers_repo.dart';
import 'package:shoply_admin/features/customers/view/customer_details_screen.dart';
import 'package:shoply_admin/features/orders/repo/orders_repo.dart';
import 'package:shoply_admin/features/orders/view/widgets/order_status_badge.dart';
import 'package:shoply_admin/core/utils/l10n/app_l10n.dart';

class OrderDetailsScreen extends StatefulWidget {
  final OrderModel order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final OrdersRepo _ordersRepo = OrdersRepo();
  late String _status = widget.order.status;
  late final Future<CustomerModel?> _customerFuture;
  bool _updating = false;

  @override
  void initState() {
    super.initState();
    _customerFuture = CustomersRepo().getCustomer(widget.order.userId);
  }

  void _notify(String message, {bool error = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? Colors.red : AppColors.primaryColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _changeStatus(String status) async {
    if (_updating || status == _status) return;
    setState(() => _updating = true);
    try {
      await _ordersRepo.updateStatus(order: widget.order, status: status);
      if (!mounted) return;
      setState(() => _status = status);
      _notify(
        context.l10n.orderMarkedAs(
          OrderStatusBadge.statusText(context, status),
        ),
      );
    } catch (e) {
      _notify(context.l10n.updateFailed('$e'), error: true);
    } finally {
      if (mounted) setState(() => _updating = false);
    }
  }

  Future<void> _showStatusSheet() async {
    final status = await showModalBottomSheet<String>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.l10n.updateStatus,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                for (final status in [
                  'pending',
                  'shipped',
                  'delivered',
                  'cancelled',
                ])
                  ListTile(
                    leading: Icon(
                      status == _status
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      color: OrderStatusBadge.statusColor(status),
                    ),
                    title: Text(
                      OrderStatusBadge.statusText(context, status),
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    onTap: () => Navigator.pop(context, status),
                  ),
              ],
            ),
          ),
        );
      },
    );

    if (status != null) await _changeStatus(status);
  }

  Future<void> _cancelOrder() async {
    final confirmed = await AppConfirmationDialog.show(
      context: context,
      title: context.l10n.cancelOrderTitle,
      message: context.l10n.cancelOrderMessage,
      confirmText: context.l10n.cancelOrder,
      cancelText: context.l10n.keep,
      icon: Icons.cancel_outlined,
      isDangerous: true,
    );

    if (!confirmed) return;

    await _changeStatus('cancelled');
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    final shipping = order.total - order.subtotal;
    final date = order.createdAt;
    final l10n = context.l10n;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.orderDetails,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          if (_status != 'cancelled')
            PopupMenuButton<String>(
              onSelected: (_) => _cancelOrder(),
              itemBuilder: (_) => [
                PopupMenuItem(value: 'cancel', child: Text(l10n.cancelOrder)),
              ],
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  order.orderNumber,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              OrderStatusBadge(status: _status),
            ],
          ),
          SizedBox(height: 4),
          Text(
            date == null
                ? l10n.processingDate
                : '${date.day}/${date.month}/${date.year} - ${date.hour}:${date.minute.toString().padLeft(2, '0')}',
            style: TextStyle(color: colors.onSurfaceVariant),
          ),
          SizedBox(height: 24),
          Text(
            l10n.customer,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          FutureBuilder<CustomerModel?>(
            future: _customerFuture,
            builder: (context, snapshot) {
              final customer = snapshot.data;
              return Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: colors.primaryContainer,
                    child: Icon(
                      Icons.person_outline,
                      color: colors.onPrimaryContainer,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          customer?.fullName ??
                              (snapshot.hasData
                                  ? l10n.unknownCustomer
                                  : l10n.loading),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          customer?.email ?? '',
                          style: TextStyle(
                            color: colors.onSurfaceVariant,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (customer != null)
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                CustomerDetailsScreen(customer: customer),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: colors.primaryContainer,
                        foregroundColor: colors.onPrimaryContainer,
                      ),
                      child: Text(
                        l10n.viewProfile,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              );
            },
          ),
          SizedBox(height: 24),
          Text(
            l10n.items,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          for (final item in order.items)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: 56,
                      height: 56,
                      child: item.image.isEmpty
                          ? Container(
                              color: colors.surfaceContainerHighest,
                              child: Icon(
                                Icons.image_outlined,
                                color: Colors.grey,
                              ),
                            )
                          : CustomCachedImageNetwork(image: item.image),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$${item.price.toStringAsFixed(2)}  x${item.quantity}',
                          style: TextStyle(
                            color: colors.onSurfaceVariant,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
            ),
          Divider(color: colors.outlineVariant),
          SizedBox(height: 8),
          _summaryRow(l10n.subtotal, order.subtotal),
          _summaryRow(l10n.shipping, shipping < 0 ? 0 : shipping),
          _summaryRow(l10n.total, order.total, isTotal: true),
          SizedBox(height: 24),
          CustomButton(
            buttonText: _updating ? l10n.updating : l10n.updateStatus,
            style: TextStyle(
              fontSize: 20,
              color: AppColors.onPrimary,
              fontWeight: FontWeight.w700,
            ),
            onPressed: _updating ? null : _showStatusSheet,
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String title, double value, {bool isTotal = false}) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: isTotal ? 17 : 15,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
                color: isTotal ? colors.onSurface : colors.onSurfaceVariant,
              ),
            ),
          ),
          Text(
            '\$${value.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: isTotal ? 17 : 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
