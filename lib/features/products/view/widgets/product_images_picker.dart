part of '../product_form_screen.dart';

class _ProductImagesPicker extends StatelessWidget {
  const _ProductImagesPicker();

  Widget _imageBox({required Widget child, required VoidCallback onRemove}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(width: 70, height: 70, child: child),
        ),
        PositionedDirectional(
          top: -6,
          end: -6,
          child: GestureDetector(
            onTap: onRemove,
            child: CircleAvatar(
              radius: 11,
              backgroundColor: Colors.red,
              child: Icon(Icons.close, size: 14, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductFormCubit, ProductFormState>(
      buildWhen: (previous, current) =>
          current is ProductFormPickImageState ||
          current is ProductFormRemoveImageState,
      builder: (context, state) {
        final cubit = context.read<ProductFormCubit>();
        final l10n = context.l10n;
        final colors = Theme.of(context).colorScheme;
        final hasImages =
            cubit.oldImages.isNotEmpty || cubit.newImages.isNotEmpty;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!hasImages)
              GestureDetector(
                onTap: cubit.pickImage,
                child: Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        size: 36,
                        color: colors.onSurfaceVariant,
                      ),
                      SizedBox(height: 8),
                      Text(
                        l10n.addProductImages,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        l10n.tapToUpload,
                        style: TextStyle(color: colors.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              )
            else
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  for (final image in cubit.oldImages)
                    _imageBox(
                      child: CustomCachedImageNetwork(image: image),
                      onRemove: () => cubit.removeOldImage(image),
                    ),
                  for (final image in cubit.newImages)
                    _imageBox(
                      child: Image.file(image, fit: BoxFit.cover),
                      onRemove: () => cubit.removeNewImage(image),
                    ),
                  GestureDetector(
                    onTap: cubit.pickImage,
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: colors.outlineVariant),
                      ),
                      child: Icon(Icons.add, color: colors.onSurfaceVariant),
                    ),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}
