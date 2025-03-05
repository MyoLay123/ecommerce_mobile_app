import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.find();

  var searchValueController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),

      // Search Bar
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextFormField(
                controller: searchValueController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: searchValueController.clear,
                    icon: const Icon(Icons.close),
                  ),
                  hintText: 'Search By Name',
                  prefixIcon: const Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                onFieldSubmitted: (value) {
                  controller.fetchProductsByName(value.toString());
                },
              ),
            ),

            const SizedBox(height: 20),

            // Brand Tabs
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0, left: 10),
                child: Row(
                  children: [
                    _buildBrandTab('assets/images/shoe2.png', '', context,
                        isSelected: true), // Replace with your logo paths
                    _buildBrandTab(
                      'assets/images/brand11.PNG',
                      'Nike',
                      context,
                    ),
                    _buildBrandTab(
                      'assets/images/brand22.png',
                      'Adidas',
                      context,
                    ),
                    _buildBrandTab(
                      'assets/images/brand33.PNG',
                      'TAMARACK',
                      context,
                    ),
                    _buildBrandTab(
                      'assets/images/brand44.PNG',
                      'Clerks',
                      context,
                    ),
                  ],
                ),
              ),
            ),

            //SizedBox(height: 10),

            // "Popular" Text and Filter Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Popular',
                    style:
                        TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                IconButton(
                    icon: const Icon(Icons.filter_list), onPressed: () {}),
              ],
            ),

            // SizedBox(height: 10),
            Expanded(child: Obx(() {
              print('controller---------${controller.isLoading.value}');
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.productList.isEmpty) {
                return noDataWidget(context);
              }
              return ListView.builder(
                  itemCount: controller.productList.length,
                  itemBuilder: (context, index) {
                    var product = controller.productList[index];

                    return InkWell(
                      onTap: () {
                        Get.offNamed(AppRoutes.PRODUCT_DETAIL,
                            arguments: product);
                      },
                      child: _buildShoeCard(
                          product.name!, product.price!, product.imageUrl!),
                    );
                  });
            })),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_border), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        currentIndex: 0, // Set initial selected index
      ),
    );
  }

  Widget _buildBrandTab(String logoPath, String brandName, context,
      {bool isSelected = false}) {
    return InkWell(
      onTap: () {
        if (brandName.isEmpty) {
          controller.fetchProducts();
        } else {
          controller.fetchProductsByBrand(brandName);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: SizedBox(
          width: 60,
          height: 42,
          child: Container(
            //  padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey[200], // Adjust colors as needed
              borderRadius: BorderRadius.circular(7),
            ),
            child: ColorFiltered(
              // Apply grayscale overlay
              colorFilter: ColorFilter.mode(
                isSelected ? Colors.transparent : Colors.grey,
                BlendMode.saturation,
              ),
              child: Image.asset(
                logoPath,
                width: 60, // Adjust logo size
                height: 40,
                color: isSelected ? Colors.white : null, // Tint selected logo
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShoeCard(String title, double price, String imageUrl) {
    Uint8List? bytes;

    bytes = base64.decode(imageUrl);
    return Container(
      // elevation: 1, // Subtle shadow

      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 10, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Price
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$$price',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Center(
                      child: Image.memory(
                        bytes,
                        fit: BoxFit.cover,
                        height: 80, // Adjust height as needed
                        width: 135,
                      ),
                    ),
                  ),
                  const Icon(Icons.favorite, color: Colors.orange, size: 20),
                ],
              ),
            ),

            // SizedBox(height: 10), // Space between price and image

            const SizedBox(height: 5), // Space between image and title

            // Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                  // margin:
                  //  const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  width: 30,
                  height: 30,
                  //  padding: EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,

                    color: Colors.black, // Circular background
                  ),
                  child: Center(
                    // icon:
                    child: Icon(
                      Icons.shopping_cart,
                      color: Colors.grey[200],
                      size: 19,
                    ),
                    // onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget noDataWidget(context) {
    return Container(
        height: 200,
        margin: const EdgeInsets.only(top: 20),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/no_data.png', width: 250, height: 250),
            Text("Whoops!",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold)),
            Container(height: 10),
            Text("No data found.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                )),
            Container(height: 25),
            const SizedBox(
              width: 180,
              height: 40,
            )
          ],
        ));
  }
}
