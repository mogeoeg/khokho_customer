// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:ev/helper/model/fetch_order_model.dart';
import 'package:ev/helper/routes/navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderCreateSuccessScreen extends StatefulWidget {
  // final CreateOrderModel order;
  const OrderCreateSuccessScreen({
    super.key,
    // required this.order,
  });

  @override
  State<OrderCreateSuccessScreen> createState() =>
      _OrderCreateSuccessScreenState();
}

class _OrderCreateSuccessScreenState extends State<OrderCreateSuccessScreen>
    with SingleTickerProviderStateMixin {
  final FetchOrderModel order = Get.arguments;

  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

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

    // Auto-redirect after 5 seconds
    Timer(const Duration(seconds: 5), () {
      Get.offNamed(AppRoutes.orderStatus, arguments: order);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
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
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Text(
                    'Order Created Successfully',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Congratulaiton! your Order is Created successfully.Enjoy your experience with us',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
