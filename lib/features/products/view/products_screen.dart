import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_admin/core/utils/theme/app_colors.dart';
import 'package:shoply_admin/core/utils/widgets/filter_chips/custom_filter_chips.dart';
import 'package:shoply_admin/core/utils/widgets/textfield/custom_search_field.dart';
import 'package:shoply_admin/features/products/view/product_details_screen.dart';
import 'package:shoply_admin/features/products/view/product_form_screen.dart';
import 'package:shoply_admin/features/products/view/widgets/product_image.dart';
import 'package:shoply_admin/features/products/view/widgets/stock_text.dart';
import 'package:shoply_admin/features/products/view_model/products_cubit.dart';
import 'package:shoply_admin/core/utils/l10n/app_l10n.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  static const filters = ['all', 'active', 'inactive'];

  Future<void> _showSortSheet(BuildContext context) async {
    final cubit = context.read<ProductsCubit>();
    final sort = await showModalBottomSheet<String>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        final l10n = context.l10n;
        final options = {
          'name': l10n.sortName,
          'priceLow': l10n.sortPriceLow,
          'priceHigh': l10n.sortPriceHigh,
          'stock': l10n.sortStock,
        };
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.sortBy,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                for (final option in options.entries)
                  ListTile(
                    leading: Icon(
                      option.key == cubit.sortBy
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: Text(
                      option.value,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    onTap: () => Navigator.pop(context, option.key),
                  ),
              ],
            ),
          ),
        );
      },
    );

    if (sort != null) cubit.changeSort(sort);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.onPrimary,
        shape: CircleBorder(),
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const ProductFormScreen()));
        },
        child: Icon(Icons.add, size: 30),
      ),
      body: SafeArea(
        child: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            final cubit = context.read<ProductsCubit>();

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Text(
                    l10n.myProducts,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: CustomSearchField(
                          hinText: l10n.searchProducts,
                          onChanged: cubit.search,
                        ),
                      ),
                      SizedBox(width: 8),
                      IconButton(
                        tooltip: l10n.sort,
                        onPressed: () => _showSortSheet(context),
                        icon: Icon(
                          Icons.tune,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  CustomFilterChips(
                    filters: filters,
                    labels: [l10n.all, l10n.active, l10n.inactive],
                    counts: filters.map(cubit.countByFilter).toList(),
                    selectedFilter: cubit.selectedFilter,
                    onSelected: cubit.changeFilter,
                  ),
                  SizedBox(height: 12),
                  Expanded(child: _buildBody(context, state)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, ProductsState state) {
    final l10n = context.l10n;
    final colors = Theme.of(context).colorScheme;

    if (state is ProductsError) {
      return Center(
        child: Text(
          l10n.failedLoadProducts(state.message),
          textAlign: TextAlign.center,
        ),
      );
    }

    if (state is! ProductsSuccess) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.products.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.inventory_2_outlined,
              size: 75,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.noProductsFound,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 90),
      itemCount: state.products.length,
      separatorBuilder: (_, _) => Divider(color: colors.outlineVariant),
      itemBuilder: (context, index) {
        final product = state.products[index];

        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: ProductImage(product: product),
          title: Text(
            product.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: colors.onSurface,
                ),
              ),
              StockText(product: product),
            ],
          ),
          trailing: Switch(
            value: product.isActive,
            onChanged: (value) {
              context.read<ProductsCubit>().setActive(product, value);
            },
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ProductDetailsScreen(product: product),
              ),
            );
          },
        );
      },
    );
  }
}
