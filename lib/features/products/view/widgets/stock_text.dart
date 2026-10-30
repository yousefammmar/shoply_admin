import 'package:flutter/material.dart';
import 'package:shoply_admin/core/model/product/product_model.dart';
import 'package:shoply_admin/core/utils/theme/app_colors.dart';
import 'package:shoply_admin/core/utils/l10n/app_l10n.dart';

class StockText extends StatelessWidget {
  final ProductModel product;

  const StockText({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Text(
      product.inStock ? context.l10n.inStock : context.l10n.outOfStock,
      style: TextStyle(
        color: product.inStock ? AppColors.delivered : AppColors.cancelled,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
