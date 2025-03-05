import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'app/controllers/home_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(HomeController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sneaker Shop',
      //theme: ThemeData.light(),
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
      initialRoute: AppRoutes.ONBOARDING,
      getPages: AppPages.pages,
    );
  }
}
