import 'package:flutter/material.dart';
import 'package:shoply_admin/core/model/product/product_model.dart';
import 'package:shoply_admin/core/utils/widgets/cached_image_network/custom_cached_image_network.dart';

class ProductImage extends StatelessWidget {
  final ProductModel product;
  final double size;

  const ProductImage({super.key, required this.product, this.size = 56});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: size,
        height: size,
        child: product.images.isEmpty
            ? Container(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: Icon(Icons.image_outlined, color: Colors.grey),
              )
            : CustomCachedImageNetwork(image: product.images.first),
      ),
    );
  }
}
