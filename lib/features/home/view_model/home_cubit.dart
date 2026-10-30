import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_admin/core/model/customer/customer_model.dart';
import 'package:shoply_admin/core/model/order/order_model.dart';
import 'package:shoply_admin/core/model/product/product_model.dart';
import 'package:shoply_admin/features/customers/repo/customers_repo.dart';
import 'package:shoply_admin/features/orders/repo/orders_repo.dart';
import 'package:shoply_admin/features/products/repo/products_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final OrdersRepo ordersRepo;
  final ProductsRepo productsRepo;
  final CustomersRepo customersRepo;

  StreamSubscription<List<OrderModel>>? _ordersSubscription;
  StreamSubscription<List<ProductModel>>? _productsSubscription;
  StreamSubscription<List<CustomerModel>>? _customersSubscription;

  List<OrderModel>? _orders;
  List<ProductModel>? _products;
  List<CustomerModel>? _customers;

  static const int lowStockLimit = 5;

  // today, week, month, all
  String selectedPeriod = 'month';

  HomeCubit({
    required this.ordersRepo,
    required this.productsRepo,
    required this.customersRepo,
  }) : super(HomeInitial());

  void loadDashboard() {
    emit(HomeLoading());

    try {
      _ordersSubscription = ordersRepo.watchAllOrders().listen((orders) {
        _orders = orders;
        _emitDashboard();
      }, onError: (error) => emit(HomeError(error.toString())));
      _productsSubscription = productsRepo.watchProducts().listen((products) {
        _products = products;
        _emitDashboard();
      }, onError: (error) => emit(HomeError(error.toString())));
      _customersSubscription = customersRepo.watchCustomers().listen((
        customers,
      ) {
        _customers = customers;
        _emitDashboard();
      }, onError: (error) => emit(HomeError(error.toString())));
    } catch (error) {
      emit(HomeError(error.toString()));
    }
  }

  void changePeriod(String period) {
    selectedPeriod = period;
    _emitDashboard();
  }

  void _emitDashboard() {
    // wait until everything loaded once
    if (_orders == null || _products == null || _customers == null) return;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    DateTime? start;
    DateTime? previousStart;
    if (selectedPeriod == 'today') {
      start = today;
      previousStart = today.subtract(Duration(days: 1));
    } else if (selectedPeriod == 'week') {
      start = today.subtract(Duration(days: 6));
      previousStart = start.subtract(Duration(days: 7));
    } else if (selectedPeriod == 'month') {
      start = DateTime(now.year, now.month);
      previousStart = DateTime(now.year, now.month - 1);
    }

    // cancelled orders don't count as sales
    final sales = _orders!
        .where((order) => order.status != 'cancelled')
        .toList();

    final periodOrders = _orders!.where((order) {
      return start == null || !_dateOf(order).isBefore(start);
    }).toList();

    final totalSales = _sumSales(sales, from: start, to: null);
    final previousSales = start == null
        ? 0.0
        : _sumSales(sales, from: previousStart, to: start);

    double? salesChange;
    if (start != null && previousSales > 0) {
      salesChange = (totalSales - previousSales) / previousSales * 100;
    }

    final products = _products!;

    emit(
      HomeSuccess(
        totalSales: totalSales,
        salesChange: salesChange,
        ordersCount: periodOrders.length,
        productsCount: products.length,
        customersCount: _customers!.length,
        todaySales: _sumSales(sales, from: today, to: null),
        pendingCount: _orders!
            .where((order) => order.status == 'pending')
            .length,
        lowStockCount: products.where((product) {
          return product.isActive &&
              product.stock != null &&
              product.stock! <= lowStockLimit;
        }).length,
        recentOrders: _orders!.take(3).toList(),
      ),
    );
  }

  double _sumSales(List<OrderModel> orders, {DateTime? from, DateTime? to}) {
    return orders
        .where((order) {
          final date = _dateOf(order);
          return (from == null || !date.isBefore(from)) &&
              (to == null || date.isBefore(to));
        })
        .fold(0, (sum, order) => sum + order.total);
  }

  // a new order has no server time yet for a moment
  DateTime _dateOf(OrderModel order) => order.createdAt ?? DateTime.now();

  @override
  Future<void> close() async {
    await _ordersSubscription?.cancel();
    await _productsSubscription?.cancel();
    await _customersSubscription?.cancel();
    return super.close();
  }
}
