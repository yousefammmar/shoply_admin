import 'package:flutter/material.dart';
import 'package:shoply_admin/core/model/customer/customer_model.dart';
import 'package:shoply_admin/core/model/order/order_model.dart';
import 'package:shoply_admin/features/customers/view/widgets/customer_avatar.dart';
import 'package:shoply_admin/features/orders/repo/orders_repo.dart';
import 'package:shoply_admin/features/orders/view/order_details_screen.dart';
import 'package:shoply_admin/features/orders/view/widgets/order_tile.dart';
import 'package:shoply_admin/core/utils/l10n/app_l10n.dart';

class CustomerDetailsScreen extends StatefulWidget {
  final CustomerModel customer;

  const CustomerDetailsScreen({super.key, required this.customer});

  @override
  State<CustomerDetailsScreen> createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  final OrdersRepo _ordersRepo = OrdersRepo();

  late final Stream<List<OrderModel>> _ordersStream;

  @override
  void initState() {
    super.initState();
    _ordersStream = _ordersRepo.watchAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    final customer = widget.customer;
    final l10n = context.l10n;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.customer,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: StreamBuilder<List<OrderModel>>(
        stream: _ordersStream,
        builder: (context, snapshot) {
          final orders = (snapshot.data ?? [])
              .where((order) => order.userId == customer.uid)
              .toList();
          final totalSpent = orders
              .where((order) => order.status != 'cancelled')
              .fold<double>(0, (sum, order) => sum + order.total);

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Center(
                child: CustomerAvatar(name: customer.fullName, radius: 40),
              ),
              SizedBox(height: 12),
              Text(
                customer.fullName.isEmpty ? customer.email : customer.fullName,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                customer.email,
                textAlign: TextAlign.center,
                style: TextStyle(color: colors.onSurfaceVariant),
              ),
              SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colors.outlineVariant),
                ),
                child: Column(
                  children: [
                    _infoRow(
                      Icons.alternate_email,
                      l10n.username,
                      customer.userName,
                    ),
                    _infoRow(
                      Icons.location_on_outlined,
                      l10n.address,
                      customer.address,
                    ),
                    _infoRow(
                      Icons.receipt_long_outlined,
                      l10n.orders,
                      '${orders.length}',
                    ),
                    _infoRow(
                      Icons.payments_outlined,
                      l10n.totalSpent,
                      '\$${totalSpent.toStringAsFixed(2)}',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Text(
                l10n.orders,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              if (!snapshot.hasData)
                Center(child: CircularProgressIndicator())
              else if (orders.isEmpty)
                Text(
                  l10n.noOrdersYet,
                  style: TextStyle(color: colors.onSurfaceVariant),
                )
              else
                for (final order in orders)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: OrderTile(
                      order: order,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => OrderDetailsScreen(order: order),
                          ),
                        );
                      },
                    ),
                  ),
            ],
          );
        },
      ),
    );
  }

  Widget _infoRow(IconData icon, String title, String value) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: colors.primary, size: 20),
          SizedBox(width: 10),
          Text(title, style: TextStyle(color: colors.onSurfaceVariant)),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              value.isEmpty ? '-' : value,
              textAlign: TextAlign.end,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
