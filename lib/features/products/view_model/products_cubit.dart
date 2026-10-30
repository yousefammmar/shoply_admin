import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_admin/core/model/product/product_model.dart';
import 'package:shoply_admin/features/products/repo/products_repo.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepo productsRepo;

  StreamSubscription<List<ProductModel>>? _subscription;

  List<ProductModel> allProducts = [];
  // all, active, inactive
  String selectedFilter = 'all';
  // name, priceLow, priceHigh, stock
  String sortBy = 'name';
  String searchText = '';

  ProductsCubit({required this.productsRepo}) : super(ProductsInitial());

  void loadProducts() {
    emit(ProductsLoading());

    try {
      _subscription?.cancel();

      _subscription = productsRepo.watchProducts().listen(
        (products) {
          allProducts = products;
          emit(ProductsSuccess(_filteredProducts()));
        },
        onError: (error) {
          emit(ProductsError(error.toString()));
        },
      );
    } catch (error) {
      emit(ProductsError(error.toString()));
    }
  }

  void changeFilter(String filter) {
    selectedFilter = filter;
    emit(ProductsSuccess(_filteredProducts()));
  }

  void changeSort(String sort) {
    sortBy = sort;
    emit(ProductsSuccess(_filteredProducts()));
  }

  void search(String text) {
    searchText = text.trim().toLowerCase();
    emit(ProductsSuccess(_filteredProducts()));
  }

  int countByFilter(String filter) {
    if (filter == 'active') return allProducts.where((p) => p.isActive).length;
    if (filter == 'inactive') {
      return allProducts.where((p) => !p.isActive).length;
    }
    return allProducts.length;
  }

  Future<void> setActive(ProductModel product, bool isActive) async {
    try {
      await productsRepo.setActive(product.id, isActive);
    } catch (error) {
      emit(ProductsError(error.toString()));
    }
  }

  List<ProductModel> _filteredProducts() {
    final products = allProducts.where((product) {
      final matchesFilter =
          selectedFilter == 'all' ||
          (selectedFilter == 'active' && product.isActive) ||
          (selectedFilter == 'inactive' && !product.isActive);
      final matchesSearch =
          searchText.isEmpty || product.name.toLowerCase().contains(searchText);
      return matchesFilter && matchesSearch;
    }).toList();

    if (sortBy == 'priceLow') {
      products.sort((a, b) => a.price.compareTo(b.price));
    } else if (sortBy == 'priceHigh') {
      products.sort((a, b) => b.price.compareTo(a.price));
    } else if (sortBy == 'stock') {
      products.sort((a, b) => (a.stock ?? 0).compareTo(b.stock ?? 0));
    } else {
      products.sort(
        (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      );
    }
    return products;
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
