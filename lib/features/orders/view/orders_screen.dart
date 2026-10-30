import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_admin/core/routes/app_pages.dart';
import 'package:shoply_admin/core/utils/widgets/filter_chips/custom_filter_chips.dart';
import 'package:shoply_admin/core/utils/widgets/textfield/custom_search_field.dart';
import 'package:shoply_admin/features/orders/view/order_details_screen.dart';
import 'package:shoply_admin/features/orders/view/widgets/order_tile.dart';
import 'package:shoply_admin/features/orders/view_model/orders_cubit.dart';
import 'package:shoply_admin/core/utils/l10n/app_l10n.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  static const statuses = [
    'all',
    'pending',
    'shipped',
    'delivered',
    'cancelled',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          final cubit = context.read<OrdersCubit>();
          final l10n = context.l10n;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.orders,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: l10n.customers,
                      icon: Icon(
                        Icons.people_outline,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, AppPages.customersScreen);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 12),
                CustomSearchField(
                  hinText: l10n.searchOrders,
                  onChanged: cubit.search,
                ),
                SizedBox(height: 12),
                CustomFilterChips(
                  filters: statuses,
                  labels: [
                    l10n.all,
                    l10n.statusPending,
                    l10n.statusShipped,
                    l10n.statusDelivered,
                    l10n.statusCancelled,
                  ],
                  counts: statuses.map(cubit.countByStatus).toList(),
                  selectedFilter: cubit.selectedStatus,
                  onSelected: cubit.changeStatus,
                ),
                SizedBox(height: 12),
                Expanded(child: _buildBody(context, state)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, OrdersState state) {
    final l10n = context.l10n;

    if (state is OrdersError) {
      return Center(
        child: Text(
          l10n.failedLoadOrders(state.message),
          textAlign: TextAlign.center,
        ),
      );
    }

    if (state is! OrdersSuccess) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.receipt_long_outlined,
              size: 75,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.noOrdersFound,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: state.orders.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final order = state.orders[index];
        return OrderTile(
          order: order,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => OrderDetailsScreen(order: order),
              ),
            );
          },
        );
      },
    );
  }
}
