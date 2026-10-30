import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_admin/core/model/order/order_model.dart';
import 'package:shoply_admin/features/orders/repo/orders_repo.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final OrdersRepo ordersRepo;

  StreamSubscription<List<OrderModel>>? _subscription;

  List<OrderModel> allOrders = [];
  String selectedStatus = 'all';
  String searchText = '';

  OrdersCubit({required this.ordersRepo}) : super(OrdersInitial());

  void loadOrders() {
    emit(OrdersLoading());

    try {
      _subscription?.cancel();

      _subscription = ordersRepo.watchAllOrders().listen(
        (orders) {
          allOrders = orders;
          emit(OrdersSuccess(_filteredOrders()));
        },
        onError: (error) {
          emit(OrdersError(error.toString()));
        },
      );
    } catch (error) {
      emit(OrdersError(error.toString()));
    }
  }

  void changeStatus(String status) {
    selectedStatus = status;
    emit(OrdersSuccess(_filteredOrders()));
  }

  void search(String text) {
    searchText = text.trim().toLowerCase();
    emit(OrdersSuccess(_filteredOrders()));
  }

  int countByStatus(String status) {
    if (status == 'all') return allOrders.length;
    return allOrders.where((order) => order.status == status).length;
  }

  List<OrderModel> _filteredOrders() {
    return allOrders.where((order) {
      final matchesStatus =
          selectedStatus == 'all' || order.status == selectedStatus;
      final matchesSearch =
          searchText.isEmpty ||
          order.orderNumber.toLowerCase().contains(searchText) ||
          order.items.any(
            (item) => item.name.toLowerCase().contains(searchText),
          );
      return matchesStatus && matchesSearch;
    }).toList();
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
