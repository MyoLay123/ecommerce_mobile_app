import 'package:get/get.dart';

import '../ui/home_screen.dart';
import '../ui/onboarding_screen.dart';
import '../ui/product_detail_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.ONBOARDING, page: () => OnboardingScreen()),
    GetPage(name: AppRoutes.HOME, page: () => HomeScreen()),
    GetPage(name: AppRoutes.PRODUCT_DETAIL, page: () => ProductDetailScreen()),
  ];
}
