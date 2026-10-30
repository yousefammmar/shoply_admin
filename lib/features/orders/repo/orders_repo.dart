import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoply_admin/core/model/order/order_model.dart';

class OrdersRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ================= WATCH ALL ORDERS =================

  // orders are saved under every user (User/{uid}/orders),
  // so read them all with a collection group
  Stream<List<OrderModel>> watchAllOrders() {
    return _firestore.collectionGroup('orders').snapshots().map((snapshot) {
      final orders = snapshot.docs.map(OrderModel.fromFirestore).toList();

      // newest first
      orders.sort((a, b) {
        final aDate = a.createdAt ?? DateTime.now();
        final bDate = b.createdAt ?? DateTime.now();
        return bDate.compareTo(aDate);
      });
      return orders;
    });
  }

  // ================= UPDATE STATUS =================

  Future<void> updateStatus({
    required OrderModel order,
    required String status,
  }) async {
    await _firestore
        .collection('User')
        .doc(order.userId)
        .collection('orders')
        .doc(order.id)
        .update({'status': status});
  }
}
