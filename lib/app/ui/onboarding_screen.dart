import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';


class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/splash_image.jpg',
                ), // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
          ).animate().fadeIn(duration: 1000.ms),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          // Content Overlay
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(
                24,
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 300,
                  ),
                  Expanded(
                      child: Center(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left:80),
                          child: const Text(
                            "Live Your",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ).animate().slideY(
                                begin: 0.5,
                                end: 0,
                                duration: 500.ms,
                                curve: Curves.easeInOut,
                              ),
                        ),
                         Container(
                          margin: EdgeInsets.only(left:100),
                          child: const Text(
                            "Perfect",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ).animate().slideY(
                                begin: 0.5,
                                end: 0,
                                delay: 100.ms,
                                duration: 500.ms,
                                curve: Curves.easeInOut,
                              ),
                        ),
                        const SizedBox(height: 12)
                            .animate()
                            .fade(duration: 300.ms),
                        const Text(
                          "Smart, gorgeous & fashionable \n collection makes you cool",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ).animate().fadeIn(
                              delay: 200.ms,
                              duration: 500.ms,
                              curve: Curves.easeInOut,
                            ),
                        const SizedBox(height: 55)
                            .animate()
                            .fade(duration: 300.ms),
                      ],
                    ),
                  )),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.HOME);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        textStyle: const TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Start',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                      .animate()
                      .scaleY(
                        begin: 0,
                        end: 1,
                        duration: 400.ms,
                        curve: Curves.easeInOutBack,
                      )
                      .fadeIn(duration: 500.ms),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
