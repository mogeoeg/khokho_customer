// 





// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:ev/helper/routes/navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> with SingleTickerProviderStateMixin  {
  late final bool isEdit;
  
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // ✅ Get argument safely (default false if not passed)
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    isEdit = args['isEdit'] ?? false;

     // ✅ Setup animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    _controller.forward();

    // Auto-redirect after 3 seconds
    Timer(const Duration(seconds: 5), () {
      Get.offAllNamed(AppRoutes.navigationMenu);
    });
  }

   @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title = isEdit ? "Profile Updated!" : "Register Successfully";
    final subtitle = isEdit
        ? "Your profile information has been updated successfully."
        : "Congratulations! Your account has been created. Enjoy your experience with us.";

    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          // scale: 1,
          // duration: const Duration(milliseconds: 700),
          // curve: Curves.easeOutBack,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 100,
                ),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
