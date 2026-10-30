part of 'product_form_cubit.dart';

abstract class ProductFormState {}

class ProductFormInitState extends ProductFormState {}

class ProductFormCategoriesLoadedState extends ProductFormState {}

class ProductFormCategoriesErrorState extends ProductFormState {
  final String errorMessage;

  ProductFormCategoriesErrorState({required this.errorMessage});
}

class ProductFormPickImageState extends ProductFormState {}

class ProductFormRemoveImageState extends ProductFormState {}

class ProductFormChangedState extends ProductFormState {}

class ProductFormImageRequiredState extends ProductFormState {}

class ProductFormLoadingState extends ProductFormState {}

class ProductFormErrorState extends ProductFormState {
  final String errorMessage;

  ProductFormErrorState({required this.errorMessage});
}

class ProductFormSuccessState extends ProductFormState {
  final String successMessage;
  // set when editing, so the details screen can show the new data
  final ProductModel? product;

  ProductFormSuccessState({required this.successMessage, this.product});
}
