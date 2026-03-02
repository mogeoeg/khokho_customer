

// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ev/utils/colors.dart';
import 'package:ev/view/help_center/help_center_screen.dart';
import 'package:ev/view/home_screen/home_screen.dart';
import 'package:ev/view/my_order/my_order_screen.dart';
import 'package:ev/view/profile/profile_screen.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  DateTime? _lastPressed;

  Future<bool> _onWillPop() async {
    final navigationController = Get.find<NavigationController>();
    final currentIndex = navigationController.selectedIndex.value;
    // Not in home tab
    if (currentIndex != 0) {
      navigationController.selectedIndex.value = 0;
      return false;
    }

    // Already in home
    DateTime now = DateTime.now();
    if (_lastPressed == null ||
        now.difference(_lastPressed!) > const Duration(seconds: 2)) {
      _lastPressed = now;
      Fluttertoast.showToast(
        msg: "Press back again to exit",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
      );
      return false;
    }
    SystemNavigator.pop();
    return true; // Exit app
  }

  @override
  Widget build(BuildContext context) {
    final navigationController = Get.put(NavigationController());
    return Obx(() {
      final currentIndex = navigationController.selectedIndex.value;
      return PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, Object? result) async {
          // Already popped by system? Ignore.
          if (didPop) return;

          final shouldPop = await _onWillPop();

          if (shouldPop) {
            // Allow the app to exit by popping the root
            Navigator.of(context).maybePop();
          }
        },
        // onWillPop: _onWillPop,
        child: SafeArea(
          top: false,
          bottom: true,
          child: Scaffold(
            body: navigationController.screens[currentIndex],
            bottomNavigationBar: NavigationBar(

              height: 74,
              elevation: 8,
              selectedIndex: navigationController.selectedIndex.value,
              indicatorColor: TColors.primary.withOpacity(0.2),
              backgroundColor: Colors.white,
              onDestinationSelected:
                  (index) => navigationController.setTab(index),
              destinations: const [
                NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
                NavigationDestination(
                  icon: Icon(Iconsax.box),
                  label: 'My Order',
                ),
                NavigationDestination(
                  icon: Icon(Iconsax.heart),
                  label: 'Help Center',
                ),
                NavigationDestination(
                  icon: Icon(Iconsax.user),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  void setTab(int index) {
    selectedIndex.value = index;
  }

  final screens = [
    const HomeScreen(),
    MyOrderScreen(),
    HelpCenterScreen(),
    ProfileScreen(),
  ];
}
