// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:ev/common/custom_alert_box.dart';
import 'package:ev/common/toast_message.dart';
import 'package:ev/controller/profile_data_controller.dart';
import 'package:ev/helper/routes/navigation.dart';
import 'package:ev/utils/image.strings.dart';
import 'package:ev/view/auth/login/login_screen.dart';
import 'package:ev/view/profile/widgets/section_item.dart';
import 'package:ev/view/profile/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileUserController profileUserController = Get.put(
      ProfileUserController(),
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("My Profile", style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(TImages.myOrderHeader),
              fit: BoxFit.cover,
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(
            100,
          ), // Adjusted to fit only tabs
          child: SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage(TImages.defaultdp),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            profileUserController.name.value.isNotEmpty
                                ? profileUserController.name.value
                                : "User Name",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            profileUserController.companyName.value.isNotEmpty
                                ? profileUserController.companyName.value
                                : "Company Name",
                            style: const TextStyle(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Expanded(
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Text(
                  //         profileDataController.name.value,
                  //         style: const TextStyle(
                  //           color: Colors.white,
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 16,
                  //         ),
                  //         overflow: TextOverflow.ellipsis,
                  //       ),
                  //       Text(
                  //         profileDataController.companyName.value,
                  //         style: const TextStyle(color: Colors.white),
                  //         overflow: TextOverflow.ellipsis,
                  //         maxLines: 2,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (profileUserController.user.value != null) {
                        Get.toNamed(AppRoutes.viewProfileDetailsScreen);
                      } else {
                        ToastMessage.show(
                          "User data is still loading...",
                          isSuccess: false,
                        );
                      }
                    },

                    // onPressed: () async {
                    //   final updated = await Get.toNamed(
                    //     AppRoutes.viewProfileDetailsScreen,
                    //   );
                    //   if (updated == true) {
                    //     profileUserController.fetchUserInfo();
                    //     print("=== ProfileScreen Info Refreshed ===");
                    //   }
                    // },
                    // onPressed:
                    //     () => Get.toNamed(AppRoutes.viewProfileDetailsScreen),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade200,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(100, 36),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "View Info",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              TSectionTitle(title: "Setting"),
              TSectionItem(
                icon: Icons.gavel,
                title: "Terms and Conditions",
                onTap: () => Get.toNamed(AppRoutes.termsAndConditionScreen),
              ),
              TSectionItem(
                icon: Icons.privacy_tip,
                title: "Privacy Policy",
                onTap: () => Get.toNamed(AppRoutes.privacyPolicyScreen),
              ),
              const SizedBox(height: 16),
              TSectionTitle(title: "Other"),
              TSectionItem(icon: Icons.share, title: "Share", onTap: () {}),
               TSectionItem(
                icon: Icons.logout,
                title: "Logout",
                onTap: () {
                  ConfirmationDialog.show(
                    context: context,
                    title: "Wanna Logout?",
                    content:
                        "You will be signed out of your account. Do you wish to continue?",
                    onConfirm: () async {
                      // Show loading dialog
                      showDialog(
                        context: context,
                        barrierDismissible:
                            false, // prevent closing by tapping outside
                        builder: (ctx) =>
                            const Center(child: CircularProgressIndicator()),
                      );

                      // Wait for at least 2 seconds (simulate processing)
                      await Future.delayed(const Duration(seconds: 2));

                      final prefs = await SharedPreferences.getInstance();
                      await prefs.clear();

                      // Close the loader
                      Navigator.of(context, rootNavigator: true).pop();

                      // Navigate to login screen
                      Get.offAll(() => LoginScreen(isLoggedIn: false));
                    },
                  );
                },
              ),
              // TSectionItem(
              //   icon: Icons.logout,
              //   title: "Logout",
              //   onTap: () {
              //     ConfirmationDialog.show(
              //       context: context,
              //       title: "Wanna Logout?",
              //       content:
              //           "You will be signed out of your account. Do you wish to continue?",

              //       onConfirm: () async {
              //         final prefs = await SharedPreferences.getInstance();
              //         await prefs.clear();
              //         Get.offAll(() => LoginScreen(isLoggedIn: false));
              //       },
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
