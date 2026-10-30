part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final double totalSales;
  // compared with the period before, null for "All Time"
  final double? salesChange;
  final int ordersCount;
  final int productsCount;
  final int customersCount;
  final double todaySales;
  final int pendingCount;
  final int lowStockCount;
  final List<OrderModel> recentOrders;

  HomeSuccess({
    required this.totalSales,
    required this.salesChange,
    required this.ordersCount,
    required this.productsCount,
    required this.customersCount,
    required this.todaySales,
    required this.pendingCount,
    required this.lowStockCount,
    required this.recentOrders,
  });
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
