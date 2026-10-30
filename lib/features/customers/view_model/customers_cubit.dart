import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_admin/core/model/customer/customer_model.dart';
import 'package:shoply_admin/core/model/order/order_model.dart';
import 'package:shoply_admin/features/customers/repo/customers_repo.dart';
import 'package:shoply_admin/features/orders/repo/orders_repo.dart';

part 'customers_state.dart';

class CustomersCubit extends Cubit<CustomersState> {
  final CustomersRepo customersRepo;
  final OrdersRepo ordersRepo;

  StreamSubscription<List<CustomerModel>>? _customersSubscription;
  StreamSubscription<List<OrderModel>>? _ordersSubscription;

  List<CustomerModel> _customers = [];
  Map<String, int> _ordersCount = {};
  String searchText = '';

  CustomersCubit({required this.customersRepo, required this.ordersRepo})
    : super(CustomersInitial());

  void loadCustomers() {
    emit(CustomersLoading());

    try {
      _customersSubscription?.cancel();
      _ordersSubscription?.cancel();

      _customersSubscription = customersRepo.watchCustomers().listen(
        (customers) {
          _customers = customers;
          _emitCustomers();
        },
        onError: (error) {
          emit(CustomersError(error.toString()));
        },
      );

      // only used to show how many orders each customer has
      _ordersSubscription = ordersRepo.watchAllOrders().listen(
        (orders) {
          _ordersCount = {};
          for (final order in orders) {
            _ordersCount[order.userId] = (_ordersCount[order.userId] ?? 0) + 1;
          }
          _emitCustomers();
        },
        onError: (error) {
          emit(CustomersError(error.toString()));
        },
      );
    } catch (error) {
      emit(CustomersError(error.toString()));
    }
  }

  void search(String text) {
    searchText = text.trim().toLowerCase();
    _emitCustomers();
  }

  void _emitCustomers() {
    final customers = _customers.where((customer) {
      return searchText.isEmpty ||
          customer.fullName.toLowerCase().contains(searchText) ||
          customer.email.toLowerCase().contains(searchText);
    }).toList();
    emit(CustomersSuccess(customers, _ordersCount));
  }

  @override
  Future<void> close() async {
    await _customersSubscription?.cancel();
    await _ordersSubscription?.cancel();
    return super.close();
  }
}
