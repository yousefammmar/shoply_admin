import 'package:cloud_firestore/cloud_firestore.dart';

class OrderItemModel {
  final String productId;
  final String name;
  final double price;
  final int quantity;
  final String image;

  OrderItemModel({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
  });

  factory OrderItemModel.fromMap(Map<String, dynamic> json) {
    return OrderItemModel(
      productId: json['productId'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      image: json['image'] ?? '',
    );
  }
}

class OrderModel {
  final String id;
  final String userId;
  final List<OrderItemModel> items;
  final double total;
  final String status;
  final DateTime? createdAt;

  OrderModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.total,
    required this.status,
    required this.createdAt,
  });

  int get itemsCount => items.fold(0, (total, item) => total + item.quantity);

  double get subtotal =>
      items.fold(0, (total, item) => total + item.price * item.quantity);

  String get orderNumber => '#${id.substring(0, 6).toUpperCase()}';

  factory OrderModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final json = doc.data() ?? {};
    final status = json['status'] ?? 'pending';

    return OrderModel(
      id: doc.id,
      // orders are saved under User/{uid}/orders
      userId: doc.reference.parent.parent?.id ?? '',
      items: (json['items'] as List<dynamic>? ?? [])
          .map(
            (item) => OrderItemModel.fromMap(Map<String, dynamic>.from(item)),
          )
          .toList(),
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      // the customer app saves new orders as 'placed'
      status: status == 'placed' ? 'pending' : status,
      createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
    );
  }
}
