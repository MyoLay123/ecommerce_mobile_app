import 'package:get/get.dart';
import '../models/product_model.dart';

class ProductController extends GetxController {
  var selectedProduct = ProductModel(
      name: '',
      description: '',
      brand: '',
      imageUrl: '',
      price: 0.0,
      rating: true,
      sizes: []).obs;
  var quantity = 1.obs;

  void setProduct(ProductModel product) {
    selectedProduct.value = product;
  }

  void increaseQuantity() {
    quantity++;
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }
}
