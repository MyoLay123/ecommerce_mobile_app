import 'package:get/get.dart';
import '../models/product_model.dart';
import '../repository/product_repository.dart';

class HomeController extends GetxController {
  final ProductRepository _productRepository = ProductRepository();
  var productList = <ProductModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var products = await _productRepository.getProducts();
      productList.assignAll(products);
    } finally {
      isLoading(false);
    }
  }

  // Fetch products by brand name
  void fetchProductsByBrand(String brand) async {
    try {
      isLoading.value = true;
      var products = await _productRepository.getProductsByBrand(brand);
      productList.assignAll(products);
      if (productList.isEmpty) {}
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

// Fetch products by product name
  void fetchProductsByName(String brand) async {
    try {
      isLoading.value = true;
      var products = await _productRepository.getProductsByName(brand);
      productList.assignAll(products);
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
