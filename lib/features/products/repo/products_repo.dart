import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shoply_admin/core/model/product/product_model.dart';
import 'package:shoply_admin/core/service/upload_image_service.dart';
import 'package:shoply_admin/core/utils/l10n/app_l10n.dart';

class ProductsRepo {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // ================= WATCH PRODUCTS =================

  Stream<List<ProductModel>> watchProducts() {
    return _fireStore.collection('products').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ProductModel.fromFirestore(doc.id, doc.data());
      }).toList();
    });
  }

  // ================= ADD PRODUCT =================

  Future<Either<String, bool>> addProduct({
    required ProductModel product,
    required List<File> newImages,
  }) async {
    try {
      final images = await _uploadImages(newImages);

      await _fireStore.collection('products').add({
        ...product.toMap(),
        'images': [...product.images, ...images],
        'createdAt': FieldValue.serverTimestamp(),
      });
      return Right(true);
    } on FirebaseException {
      return Left(appL10n.failedAddProduct);
    } catch (e) {
      return Left(appL10n.unexpectedError('$e'));
    }
  }

  // ================= UPDATE PRODUCT =================

  // returns the saved product so the details screen can show it
  Future<Either<String, ProductModel>> updateProduct({
    required ProductModel product,
    required List<File> newImages,
  }) async {
    try {
      final images = await _uploadImages(newImages);

      final updatedProduct = ProductModel(
        id: product.id,
        name: product.name,
        description: product.description,
        price: product.price,
        categoryId: product.categoryId,
        images: [...product.images, ...images],
        isTrending: product.isTrending,
        stock: product.stock,
        isActive: product.isActive,
      );

      await _fireStore
          .collection('products')
          .doc(product.id)
          .update(updatedProduct.toMap());
      return Right(updatedProduct);
    } on FirebaseException {
      return Left(appL10n.failedUpdateProduct);
    } catch (e) {
      return Left(appL10n.unexpectedError('$e'));
    }
  }

  // ================= ACTIVE / INACTIVE =================

  Future<void> setActive(String productId, bool isActive) async {
    await _fireStore.collection('products').doc(productId).update({
      'isActive': isActive,
    });
  }

  // ================= DELETE PRODUCT =================

  Future<void> deleteProduct(String productId) async {
    await _fireStore.collection('products').doc(productId).delete();
  }

  Future<List<String>> _uploadImages(List<File> images) async {
    final urls = <String>[];
    for (final image in images) {
      final url = await UploadImageService.uplaodImage(imageFile: image);
      if (url != null) urls.add(url);
    }
    return urls;
  }
}
