import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_admin/core/utils/widgets/textfield/custom_search_field.dart';
import 'package:shoply_admin/features/customers/view/customer_details_screen.dart';
import 'package:shoply_admin/features/customers/view/widgets/customer_avatar.dart';
import 'package:shoply_admin/features/customers/view_model/customers_cubit.dart';
import 'package:shoply_admin/core/utils/l10n/app_l10n.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CustomersCubit>();
    final l10n = context.l10n;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.customers,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            CustomSearchField(
              hinText: l10n.searchCustomers,
              onChanged: cubit.search,
            ),
            SizedBox(height: 12),
            Expanded(
              child: BlocBuilder<CustomersCubit, CustomersState>(
                builder: (context, state) {
                  if (state is CustomersError) {
                    return Center(
                      child: Text(
                        l10n.failedLoadCustomers(state.message),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  if (state is! CustomersSuccess) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.customers.isEmpty) {
                    return Center(
                      child: Text(
                        l10n.noCustomersFound,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    itemCount: state.customers.length,
                    separatorBuilder: (_, _) =>
                        Divider(color: colors.outlineVariant),
                    itemBuilder: (context, index) {
                      final customer = state.customers[index];
                      final ordersCount = state.ordersCount[customer.uid] ?? 0;

                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CustomerAvatar(name: customer.fullName),
                        title: Text(
                          customer.fullName.isEmpty
                              ? customer.email
                              : customer.fullName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              customer.email,
                              style: TextStyle(color: colors.onSurfaceVariant),
                            ),
                            Text(
                              l10n.ordersCount(ordersCount),
                              style: TextStyle(
                                color: colors.onSurfaceVariant,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        trailing: Icon(Icons.chevron_right, color: Colors.grey),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  CustomerDetailsScreen(customer: customer),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
