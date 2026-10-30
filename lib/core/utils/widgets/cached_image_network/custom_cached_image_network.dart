import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoply_admin/core/utils/theme/app_colors.dart';

class CustomCachedImageNetwork extends StatelessWidget {
  const CustomCachedImageNetwork({
    super.key,
    required this.image,
    this.errorWidget,
  });
  final String image;
  final Widget? errorWidget;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: 120,
      width: 150,
      imageUrl: image,
      fit: BoxFit.cover,
      placeholder: (context, url) => Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      errorWidget: (context, url, error) =>
          errorWidget ??
          Icon(Icons.error_outline, size: 28, color: AppColors.error),
    );
  }
}
