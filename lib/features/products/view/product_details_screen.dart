import 'package:flutter/material.dart';
import 'package:shoply_admin/core/model/category/category_model.dart';
import 'package:shoply_admin/core/model/product/product_model.dart';
import 'package:shoply_admin/core/repositories/category_repository.dart';
import 'package:shoply_admin/core/utils/theme/app_colors.dart';
import 'package:shoply_admin/core/utils/widgets/cached_image_network/custom_cached_image_network.dart';
import 'package:shoply_admin/core/utils/widgets/dialog/app_confirmation_dialog.dart';
import 'package:shoply_admin/features/products/repo/products_repo.dart';
import 'package:shoply_admin/features/products/view/product_form_screen.dart';
import 'package:shoply_admin/core/utils/l10n/app_l10n.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductsRepo _productsRepo = ProductsRepo();
  late ProductModel _product = widget.product;
  late final Future<List<CategoryModel>> _categoriesFuture;
  int _selectedImage = 0;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = CategoryRepository().getCategories();
  }

  void _notify(String message, {bool error = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? Colors.red : AppColors.primaryColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _setActive(bool isActive) async {
    try {
      await _productsRepo.setActive(_product.id, isActive);
      if (!mounted) return;
      setState(() {
        _product = ProductModel(
          id: _product.id,
          name: _product.name,
          description: _product.description,
          price: _product.price,
          categoryId: _product.categoryId,
          images: _product.images,
          isTrending: _product.isTrending,
          stock: _product.stock,
          isActive: isActive,
        );
      });
    } catch (e) {
      _notify(context.l10n.updateFailed('$e'), error: true);
    }
  }

  Future<void> _edit() async {
    final updated = await Navigator.of(context).push<ProductModel>(
      MaterialPageRoute(builder: (_) => ProductFormScreen(product: _product)),
    );
    if (updated != null && mounted) {
      setState(() {
        _product = updated;
        _selectedImage = 0;
      });
    }
  }

  Future<void> _delete() async {
    final confirmed = await AppConfirmationDialog.show(
      context: context,
      title: context.l10n.deleteProductTitle,
      message: context.l10n.deleteProductMessage(_product.name),
      confirmText: context.l10n.delete,
      icon: Icons.delete_outline,
      isDangerous: true,
    );

    if (!confirmed || !mounted) return;

    try {
      await _productsRepo.deleteProduct(_product.id);
      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      _notify(context.l10n.deleteFailed('$e'), error: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = _product;
    final l10n = context.l10n;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.productDetails,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: l10n.delete,
            onPressed: _delete,
            icon: Icon(Icons.delete_outline, color: AppColors.cancelled),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 240,
              color: colors.surfaceContainerHighest,
              child: product.images.isEmpty
                  ? Icon(Icons.image_outlined, size: 70, color: Colors.grey)
                  : CustomCachedImageNetwork(
                      image: product.images[_selectedImage],
                    ),
            ),
          ),
          if (product.images.length > 1) ...[
            SizedBox(height: 12),
            SizedBox(
              height: 60,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: product.images.length,
                separatorBuilder: (_, _) => SizedBox(width: 10),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => setState(() => _selectedImage = index),
                    child: Container(
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: index == _selectedImage
                              ? colors.primary
                              : colors.outlineVariant,
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CustomCachedImageNetwork(
                          image: product.images[index],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Text(
                  product.name,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                tooltip: l10n.edit,
                onPressed: _edit,
                icon: Icon(Icons.edit_outlined, color: colors.primary),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color:
                      (product.inStock
                              ? AppColors.delivered
                              : AppColors.cancelled)
                          .withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  product.inStock ? l10n.inStock : l10n.outOfStock,
                  style: TextStyle(
                    color: product.inStock
                        ? AppColors.delivered
                        : AppColors.cancelled,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            l10n.description,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 6),
          Text(
            product.description.isEmpty
                ? l10n.noDescription
                : product.description,
            style: TextStyle(
              color: colors.onSurfaceVariant,
              fontSize: 15,
              height: 1.5,
            ),
          ),
          SizedBox(height: 20),
          Divider(color: colors.outlineVariant),
          _infoRow(
            l10n.stockQuantity,
            product.stock == null ? l10n.notSet : '${product.stock}',
          ),
          Divider(color: colors.outlineVariant),
          FutureBuilder<List<CategoryModel>>(
            future: _categoriesFuture,
            builder: (context, snapshot) {
              final category = (snapshot.data ?? [])
                  .where((category) => category.id == product.categoryId)
                  .firstOrNull;
              return _infoRow(
                l10n.category,
                category?.name ?? product.categoryId,
              );
            },
          ),
          Divider(color: colors.outlineVariant),
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.active,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Switch(value: product.isActive, onChanged: _setActive),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
