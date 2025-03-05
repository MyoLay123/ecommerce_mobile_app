import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_controller..dart';
import 'dart:math' as math;
import 'dart:convert';
import 'dart:typed_data';

class ProductDetailScreen extends StatefulWidget {
  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // Ensures correct AppBar height

  var quantity = 1.obs;

  final ProductController controller = Get.put(ProductController());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 50), // Adjust duration as needed
      vsync: this,
    )..repeat(); // Repeat animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.put(ProductController());
    var product = Get.arguments;
    Uint8List? bytes;
    bytes = base64.decode("${product.imageUrl}");

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.grey.shade800),
          onPressed: () {
            Get.back();
          },
        ),
        // Leading Icon (Chevron Left)

        actions: [
          // Action Icon (Filled Heart)
          Container(
            margin: const EdgeInsets.only(right: 10),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[100], // Light gray background
            ),
            child: IconButton(
              icon: Icon(
                Icons.favorite,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () {
                // Handle favorite button press
              },
            ),
          ),
        ],
        backgroundColor: Colors.white, // Match the background color
        elevation: 0, // Remove shadow for a clean look
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align text to the left
          children: [
            SizedBox(
              width: 250, // Adjust width as needed
              height: 250,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001) // Perspective
                      ..rotateY(_controller.value * 2 * math.pi),
                    alignment: Alignment.center,
                    child: child,
                  );
                },
                child: Image.memory(
                  bytes,
                  width: 200, // Adjust width as needed
                  height: 300,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            // Product Details
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Men\'s Shoes',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey, // Match text color
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "${product.name}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 16,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 4),
                          const Text('(4.7)',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey)),
                        ],
                      ), // Match star color

                      const SizedBox(height: 8),
                      Text(
                        "\$${product.price}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87, // Match price color
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16,
                top: 5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Size Selection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Size::', style: TextStyle(fontSize: 16)),
                      Row(
                        children: const [
                          //  SizedBox(width: 16),
                          Text('US',
                              style: TextStyle(
                                fontSize: 14,
                              )),
                          SizedBox(width: 8),
                          Text('UK',
                              style: TextStyle(
                                fontSize: 14,
                              )),
                          SizedBox(width: 8),
                          Text('EU',
                              style: TextStyle(
                                fontSize: 14,
                              )),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Row(
                        children: [
                          _buildSizeButton(product.sizes[0], false),
                          _buildSizeButton(product.sizes[1], true),
                          _buildSizeButton(product.sizes[2], false),
                          _buildSizeButton(product.sizes[3], false),
                          _buildSizeButton(product.sizes[4], false),
                        ],
                      ),
                    ),
                  ),
                  //   SizedBox(height: 5),

                  // Description
                  _buildExpandableSection(
                    'Description',
                    "${product.description}",
                  ),

                  // Free Delivery and Returns
                  _buildExpandableSection('Free Delivery and Returns',
                      'Details about free delivery and returns.'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Color Selection
                  Row(
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white, // Light gray background
                        ),
                        child: Icon(
                          Icons.check,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ), // Checkmark icon
                      const SizedBox(width: 8),
                      _buildColorCircle(Colors.black),
                      _buildColorCircle(Colors.green),
                      _buildColorCircle(Colors.purple),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Quantity
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Quantity',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400)),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.remove,
                              size: 20,
                            ),
                            onPressed: controller.decreaseQuantity,
                          ),
                          Obx(
                            () => Text("${controller.quantity}",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.add,
                              size: 20,
                            ),
                            onPressed: controller.increaseQuantity,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Add to Cart Button
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        height: 60,
        child: ElevatedButton(
          onPressed: () {
            // Handle add to cart logic
          },
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: const Size(double.infinity, 50), // Full width
          ),
          child: const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Add to Cart',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColorCircle(Color color) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
      ),
    );
  }

  Widget _buildSizeButton(String size, bool isSelected) {
    //bool isSelected = _selectedSize == size;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, bottom: 5),
      child: SizedBox(
        width: 70, // Set width
        height: 50, // Set height
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            primary: isSelected ? Colors.orange : Colors.grey.shade200,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),

            //  minimumSize: Size(40, 40), // Adjust size as needed
          ),
          child: Text(size,
              style:
                  TextStyle(color: isSelected ? Colors.white : Colors.black)),
        ),
      ),
    );
  }

  Widget _buildExpandableSection(String title, String content) {
    return Column(
      children: [
        ExpansionTile(
          title: Text(title, style: const TextStyle(fontSize: 16)),
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
          children: <Widget>[
            Text(content),
          ],
        ),
        Divider(
          height: 1,
          thickness: 1,
          // indent: 16, // Indent to match the text
          // endIndent: 16,
          color: Colors.grey[300], // Subtle gray color
        ),
      ],
    );
  }
}

// Custom clipper for harp shape
class HarpClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(
      size.width / 4,
      size.height * 0.2,
      size.width / 2,
      0,
    );
    path.quadraticBezierTo(
      size.width * 3 / 4,
      size.height * 0.2,
      size.width,
      size.height,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

// Custom painter for the indicator
class IndicatorPainter extends CustomPainter {
  final Color color;

  IndicatorPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final radius = math.min(size.width, size.height) / 2;
    canvas.drawArc(rect, 0, 2 * math.pi, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
