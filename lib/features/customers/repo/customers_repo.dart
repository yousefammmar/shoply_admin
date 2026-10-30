import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoply_admin/core/model/customer/customer_model.dart';

class CustomersRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ================= WATCH CUSTOMERS =================

  Stream<List<CustomerModel>> watchCustomers() {
    return _firestore.collection('User').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return CustomerModel.fromFirestore(doc.id, doc.data());
      }).toList();
    });
  }

  // ================= GET CUSTOMER =================

  Future<CustomerModel?> getCustomer(String uid) async {
    final snapshot = await _firestore.collection('User').doc(uid).get();

    if (!snapshot.exists) return null;

    return CustomerModel.fromFirestore(snapshot.id, snapshot.data()!);
  }
}
