import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_admin/core/model/product/product_model.dart';
import 'package:shoply_admin/core/utils/theme/app_colors.dart';
import 'package:shoply_admin/core/utils/widgets/button/custom_button.dart';
import 'package:shoply_admin/core/utils/widgets/cached_image_network/custom_cached_image_network.dart';
import 'package:shoply_admin/core/utils/widgets/dialog/custom_dialog_error.dart';
import 'package:shoply_admin/core/utils/widgets/dialog/custom_success_dialog.dart';
import 'package:shoply_admin/core/utils/widgets/loading/custom_loading.dart';
import 'package:shoply_admin/core/utils/widgets/textfield/custom_text_field.dart';
import 'package:shoply_admin/features/products/view_model/product_form_cubit.dart';
import 'package:shoply_admin/core/utils/l10n/app_l10n.dart';
part 'widgets/product_images_picker.dart';
part 'widgets/product_form_fields.dart';

// Used for both "Add Product" and "Edit Product"
class ProductFormScreen extends StatelessWidget {
  final ProductModel? product;

  const ProductFormScreen({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductFormCubit(product: product)..loadCategories(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<ProductFormCubit>();
          final l10n = context.l10n;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                cubit.isEditing ? l10n.editProduct : l10n.addProduct,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              elevation: 0,
            ),
            body: BlocListener<ProductFormCubit, ProductFormState>(
              listener: (context, state) {
                if (state is ProductFormLoadingState) {
                  CustomLoading.showDialogLoading(context: context);
                } else if (state is ProductFormErrorState) {
                  Navigator.pop(context);
                  CustomDialogError.showProDialogError(
                    context: context,
                    title: l10n.saveError,
                    description: state.errorMessage,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  );
                } else if (state is ProductFormSuccessState) {
                  Navigator.pop(context);
                  CustomSuccessDialog.showProSuccessDialog(
                    context: context,
                    title: l10n.saved,
                    description: state.successMessage,
                    onPressed: () {
                      // close the dialog, then the form
                      Navigator.pop(context);
                      Navigator.pop(context, state.product);
                    },
                  );
                } else if (state is ProductFormImageRequiredState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.addImageRequired),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                } else if (state is ProductFormCategoriesErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        l10n.couldNotLoadCategories(state.errorMessage),
                      ),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: cubit.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ProductImagesPicker(),
                        SizedBox(height: 20),
                        _ProductFormFields(),
                        SizedBox(height: 10),
                        CustomButton(
                          buttonText: cubit.isEditing
                              ? l10n.updateProduct
                              : l10n.saveProduct,
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColors.onPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                          onPressed: () {
                            cubit.saveProduct();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
