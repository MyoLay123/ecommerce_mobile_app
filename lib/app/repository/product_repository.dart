import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class ProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ProductModel>> getProducts() async {
    try {
      var querySnapshot = await _firestore.collection("products").get();

      return querySnapshot.docs.map((doc) {
        return ProductModel.fromJson(doc.data());
      }).toList();
    } catch (e) {
      throw Exception("Error fetching products: $e");
    }
  }

  // Fetch products by brand name
  Future<List<ProductModel>> getProductsByBrand(String brand) async {
    try {
      var querySnapshot = await _firestore
          .collection("products")
          .where("brand", isEqualTo: brand)
          .get();

      return querySnapshot.docs.map((doc) {
        return ProductModel.fromJson(doc.data());
      }).toList();
    } catch (e) {
      throw Exception("Error fetching products: $e");
    }
  }

  Future<List<ProductModel>> getProductsByName(String brand) async {
    try {
      var querySnapshot = await _firestore
          .collection("products")
          .where("name", isEqualTo: brand)
          .get();

      return querySnapshot.docs.map((doc) {
        return ProductModel.fromJson(doc.data());
      }).toList();
    } catch (e) {
      throw Exception("Error fetching products: $e");
    }
  }
}
