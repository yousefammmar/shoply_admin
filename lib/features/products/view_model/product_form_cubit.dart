import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_admin/core/helper/image_picker_helper.dart';
import 'package:shoply_admin/core/model/category/category_model.dart';
import 'package:shoply_admin/core/model/product/product_model.dart';
import 'package:shoply_admin/core/repositories/category_repository.dart';
import 'package:shoply_admin/features/products/repo/products_repo.dart';
import 'package:shoply_admin/core/utils/l10n/app_l10n.dart';

part 'product_form_state.dart';

class ProductFormCubit extends Cubit<ProductFormState> {
  // null when adding a new product
  final ProductModel? product;

  ProductFormCubit({this.product}) : super(ProductFormInitState()) {
    nameController.text = product?.name ?? '';
    descriptionController.text = product?.description ?? '';
    priceController.text = product == null
        ? ''
        : product!.price.toStringAsFixed(2);
    stockController.text = product?.stock?.toString() ?? '';
    categoryId = product?.categoryId;
    isActive = product?.isActive ?? true;
    oldImages = List.of(product?.images ?? []);
  }

  final _productsRepo = ProductsRepo();
  final _categoryRepository = CategoryRepository();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  List<CategoryModel> categories = [];
  String? categoryId;
  bool isActive = true;
  List<String> oldImages = [];
  List<File> newImages = [];

  bool get isEditing => product != null;

  Future<void> loadCategories() async {
    try {
      categories = await _categoryRepository.getCategories();
      emit(ProductFormCategoriesLoadedState());
    } catch (e) {
      emit(ProductFormCategoriesErrorState(errorMessage: e.toString()));
    }
  }

  void pickImage() async {
    final imageFile = await ImagePickerHelper.pickImageGallery();
    if (imageFile == null) return;
    newImages.add(File(imageFile.path));
    emit(ProductFormPickImageState());
  }

  void removeOldImage(String image) {
    oldImages.remove(image);
    emit(ProductFormRemoveImageState());
  }

  void removeNewImage(File image) {
    newImages.remove(image);
    emit(ProductFormRemoveImageState());
  }

  void changeCategory(String? id) {
    categoryId = id;
    emit(ProductFormChangedState());
  }

  void changeActive(bool value) {
    isActive = value;
    emit(ProductFormChangedState());
  }

  Future<void> saveProduct() async {
    if (formKey.currentState?.validate() ?? false) {
      if (oldImages.isEmpty && newImages.isEmpty) {
        emit(ProductFormImageRequiredState());
        return;
      }

      emit(ProductFormLoadingState());

      final formProduct = ProductModel(
        id: product?.id ?? '',
        name: nameController.text.trim(),
        description: descriptionController.text.trim(),
        price: double.parse(priceController.text),
        categoryId: categoryId!,
        images: oldImages,
        isTrending: product?.isTrending ?? false,
        stock: int.parse(stockController.text),
        isActive: isActive,
      );

      if (isEditing) {
        final result = await _productsRepo.updateProduct(
          product: formProduct,
          newImages: newImages,
        );
        result.fold(
          (errorMessage) {
            emit(ProductFormErrorState(errorMessage: errorMessage));
          },
          (savedProduct) {
            emit(
              ProductFormSuccessState(
                successMessage: appL10n.productUpdated,
                product: savedProduct,
              ),
            );
          },
        );
      } else {
        final result = await _productsRepo.addProduct(
          product: formProduct,
          newImages: newImages,
        );
        result.fold(
          (errorMessage) {
            emit(ProductFormErrorState(errorMessage: errorMessage));
          },
          (_) {
            emit(ProductFormSuccessState(successMessage: appL10n.productAdded));
          },
        );
      }
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    stockController.dispose();
    return super.close();
  }
}
