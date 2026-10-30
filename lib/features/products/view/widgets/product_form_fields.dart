part of '../product_form_screen.dart';

class _ProductFormFields extends StatelessWidget {
  const _ProductFormFields();

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductFormCubit, ProductFormState>(
      buildWhen: (previous, current) =>
          current is ProductFormCategoriesLoadedState ||
          current is ProductFormChangedState,
      builder: (context, state) {
        final cubit = context.read<ProductFormCubit>();
        final l10n = context.l10n;
        final colors = Theme.of(context).colorScheme;
        // the old category may have been deleted
        final categoryExists = cubit.categories.any(
          (category) => category.id == cubit.categoryId,
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label(l10n.productName),
            CustomTextField(
              validator: (name) {
                if (name?.trim().isEmpty ?? true) {
                  return l10n.productNameRequired;
                }
                return null;
              },
              controller: cubit.nameController,
              hinText: l10n.productNameHint,
            ),
            _label(l10n.description),
            CustomTextField(
              controller: cubit.descriptionController,
              hinText: l10n.descriptionHint,
              maxLines: 4,
            ),
            _label(l10n.price),
            CustomTextField(
              validator: (price) {
                final value = double.tryParse(price ?? '');
                if (price?.isEmpty ?? true) {
                  return l10n.priceRequired;
                } else if (value == null || value <= 0) {
                  return l10n.priceInvalid;
                }
                return null;
              },
              controller: cubit.priceController,
              hinText: '0.00',
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              prefixIcon: Icon(Icons.attach_money),
            ),
            _label(l10n.stockQuantity),
            CustomTextField(
              validator: (stock) {
                final value = int.tryParse(stock ?? '');
                if (stock?.isEmpty ?? true) {
                  return l10n.stockRequired;
                } else if (value == null || value < 0) {
                  return l10n.stockInvalid;
                }
                return null;
              },
              controller: cubit.stockController,
              hinText: '0',
              keyboardType: TextInputType.number,
            ),
            _label(l10n.category),
            DropdownButtonFormField<String>(
              // rebuild once the categories arrive so the saved one is selected
              key: ValueKey(cubit.categories.length),
              initialValue: categoryExists ? cubit.categoryId : null,
              items: [
                for (final category in cubit.categories)
                  DropdownMenuItem(
                    value: category.id,
                    child: Text(category.name),
                  ),
              ],
              onChanged: cubit.changeCategory,
              validator: (value) =>
                  value == null ? l10n.categoryRequired : null,
              hint: Text(
                l10n.selectCategory,
                style: TextStyle(color: colors.onSurfaceVariant, fontSize: 17),
              ),
              decoration: InputDecoration(
                helperText: '',
                filled: true,
                fillColor: colors.surfaceContainerHighest,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 17,
                  horizontal: 10,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            if (cubit.isEditing)
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.active,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Switch(value: cubit.isActive, onChanged: cubit.changeActive),
                ],
              ),
          ],
        );
      },
    );
  }
}
