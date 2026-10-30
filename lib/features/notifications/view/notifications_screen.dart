import 'package:flutter/material.dart';
import 'package:shoply_admin/core/local/local_storage.dart';
import 'package:shoply_admin/core/utils/l10n/app_l10n.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _newOrders = LocalStorage.instance.getNewOrdersAlert();
  bool _lowStock = LocalStorage.instance.getLowStockAlert();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.notifications,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: _newOrders,
            title: Text(
              l10n.newOrders,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(l10n.newOrdersSubtitle),
            onChanged: (value) async {
              setState(() => _newOrders = value);
              await LocalStorage.instance.setNewOrdersAlert(isOn: value);
            },
          ),
          Divider(color: Theme.of(context).colorScheme.outlineVariant),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: _lowStock,
            title: Text(
              l10n.lowStock,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(l10n.lowStockSubtitle),
            onChanged: (value) async {
              setState(() => _lowStock = value);
              await LocalStorage.instance.setLowStockAlert(isOn: value);
            },
          ),
        ],
      ),
    );
  }
}
