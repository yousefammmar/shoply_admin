import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_admin/core/navigation/cubit/main_cubit.dart';
import 'package:shoply_admin/core/navigation/cubit/main_state.dart';
import 'package:shoply_admin/core/navigation/widget/admin_bottom_nav_bar.dart';
import 'package:shoply_admin/features/customers/repo/customers_repo.dart';
import 'package:shoply_admin/features/home/view/home_screen.dart';
import 'package:shoply_admin/features/home/view_model/home_cubit.dart';
import 'package:shoply_admin/features/more/view/more_screen.dart';
import 'package:shoply_admin/features/orders/repo/orders_repo.dart';
import 'package:shoply_admin/features/orders/view/orders_screen.dart';
import 'package:shoply_admin/features/orders/view_model/orders_cubit.dart';
import 'package:shoply_admin/features/products/repo/products_repo.dart';
import 'package:shoply_admin/features/products/view/products_screen.dart';
import 'package:shoply_admin/features/products/view_model/products_cubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    // OrdersCubit is above the tabs so Home can open Orders on a filter
    providers: [
      BlocProvider<OrdersCubit>(
        create: (_) => OrdersCubit(ordersRepo: OrdersRepo())..loadOrders(),
      ),
      BlocProvider<ProductsCubit>(
        create: (_) =>
            ProductsCubit(productsRepo: ProductsRepo())..loadProducts(),
      ),
    ],
    child: BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        final mainCubit = context.read<MainCubit>();
        return Scaffold(
          body: IndexedStack(
            index: mainCubit.selectedIndex,
            children: [
              BlocProvider<HomeCubit>(
                create: (_) => HomeCubit(
                  ordersRepo: OrdersRepo(),
                  productsRepo: ProductsRepo(),
                  customersRepo: CustomersRepo(),
                )..loadDashboard(),
                child: const HomeScreen(),
              ),
              const ProductsScreen(),
              const OrdersScreen(),
              const MoreScreen(),
            ],
          ),
          bottomNavigationBar: AdminBottomNavBar(
            selectedIndex: mainCubit.selectedIndex,
            onTabChange: mainCubit.changeTab,
          ),
        );
      },
    ),
  );
}
