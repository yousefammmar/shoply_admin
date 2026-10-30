import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_admin/core/local/local_storage.dart';
import 'package:shoply_admin/core/local/local_storage_user.dart';
import 'package:shoply_admin/core/navigation/cubit/main_cubit.dart';
import 'package:shoply_admin/core/routes/app_pages.dart';
import 'package:shoply_admin/core/utils/theme/app_colors.dart';
import 'package:shoply_admin/features/home/view/widgets/sales_card.dart';
import 'package:shoply_admin/features/home/view/widgets/stat_tile.dart';
import 'package:shoply_admin/features/home/view_model/home_cubit.dart';
import 'package:shoply_admin/features/orders/view/order_details_screen.dart';
import 'package:shoply_admin/features/orders/view/widgets/order_tile.dart';
import 'package:shoply_admin/features/orders/view_model/orders_cubit.dart';
import 'package:shoply_admin/core/utils/l10n/app_l10n.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _greeting(AppLocalizations l10n) {
    final hour = DateTime.now().hour;
    if (hour < 12) return l10n.goodMorning;
    if (hour < 17) return l10n.goodAfternoon;
    return l10n.goodEvening;
  }

  void _openOrders(BuildContext context, String status) {
    context.read<OrdersCubit>().changeStatus(status);
    context.read<MainCubit>().changeTab(2);
  }

  @override
  Widget build(BuildContext context) {
    final user = LocalStorageUser.instance;
    final l10n = context.l10n;
    final colors = Theme.of(context).colorScheme;
    final name = user.fullName.isEmpty ? l10n.admin : user.fullName;

    return SafeArea(
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();

          if (state is HomeError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  l10n.failedLoadDashboard(state.message),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          if (state is! HomeSuccess) {
            return const Center(child: CircularProgressIndicator());
          }

          final showBadge =
              LocalStorage.instance.getNewOrdersAlert() &&
              state.pendingCount > 0;
          final showLowStock =
              LocalStorage.instance.getLowStockAlert() &&
              state.lowStockCount > 0;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _greeting(l10n),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: colors.primaryContainer,
                    backgroundImage: user.profileImage.isEmpty
                        ? null
                        : NetworkImage(user.profileImage),
                    child: user.profileImage.isEmpty
                        ? Icon(Icons.person, color: colors.onPrimaryContainer)
                        : null,
                  ),
                  SizedBox(width: 6),
                  IconButton(
                    tooltip: l10n.pendingOrders,
                    onPressed: () => _openOrders(context, 'pending'),
                    icon: Badge(
                      isLabelVisible: showBadge,
                      label: Text('${state.pendingCount}'),
                      child: Icon(Icons.notifications_none, size: 28),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18),
              SalesCard(
                totalSales: state.totalSales,
                salesChange: state.salesChange,
                selectedPeriod: cubit.selectedPeriod,
                onPeriodChanged: cubit.changePeriod,
              ),
              SizedBox(height: 14),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.9,
                children: [
                  StatTile(
                    title: l10n.orders,
                    value: '${state.ordersCount}',
                    icon: Icons.receipt_long_outlined,
                    color: AppColors.pending,
                    onTap: () => _openOrders(context, 'all'),
                  ),
                  StatTile(
                    title: l10n.products,
                    value: '${state.productsCount}',
                    icon: Icons.inventory_2_outlined,
                    color: Colors.indigo,
                    onTap: () => context.read<MainCubit>().changeTab(1),
                  ),
                  StatTile(
                    title: l10n.customers,
                    value: '${state.customersCount}',
                    icon: Icons.people_outline,
                    color: Colors.deepOrange,
                    onTap: () =>
                        Navigator.pushNamed(context, AppPages.customersScreen),
                  ),
                  StatTile(
                    title: l10n.today,
                    value: '\$${state.todaySales.toStringAsFixed(2)}',
                    icon: Icons.today_outlined,
                    color: AppColors.shipped,
                  ),
                ],
              ),
              if (showLowStock) ...[
                SizedBox(height: 14),
                GestureDetector(
                  onTap: () => context.read<MainCubit>().changeTab(1),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.pending.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: AppColors.pending,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            l10n.lowStockWarning(state.lowStockCount),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.pending,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              SizedBox(height: 22),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.recentOrders,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _openOrders(context, 'all'),
                    child: Text(
                      l10n.seeAll,
                      style: TextStyle(
                        color: colors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              if (state.recentOrders.isEmpty)
                Text(
                  l10n.noOrdersYet,
                  style: TextStyle(color: colors.onSurfaceVariant),
                )
              else
                for (final order in state.recentOrders)
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
}
