part of 'customers_cubit.dart';

abstract class CustomersState {}

class CustomersInitial extends CustomersState {}

class CustomersLoading extends CustomersState {}

class CustomersSuccess extends CustomersState {
  final List<CustomerModel> customers;
  final Map<String, int> ordersCount;

  CustomersSuccess(this.customers, this.ordersCount);
}

class CustomersError extends CustomersState {
  final String message;

  CustomersError(this.message);
}
