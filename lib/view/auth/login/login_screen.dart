import 'package:ev/common/policy_text.dart';
import 'package:ev/navigation_menu.dart';
import 'package:ev/utils/image.strings.dart';
import 'package:ev/view/auth/login/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/login_controller.dart';
import '../../../common/button.dart';

class LoginScreen extends StatelessWidget {
    final bool isLoggedIn;
  LoginScreen({super.key, required this.isLoggedIn});

  final GlobalKey<TLoginFormState> _formKey = GlobalKey<TLoginFormState>();
  final LoginAuthController controller = Get.put(LoginAuthController());

  @override
  Widget build(BuildContext context) {


      // Check login status immediately
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isLoggedIn) {
        // Navigate to main menu if user is logged in
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => NavigationMenu()),
        );
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(TImages.loginImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Shipping and Track Anytime',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Get great experience with Kho-Kho',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  // const TAuthHeader(
                  //   title: 'Shipping and Track Anytime',
                  //   subTitle: 'Get great experience with tracky',
                  // //  isLogoNeeded: true,
                  // ),
                  const SizedBox(height: 32),
                  TLoginForm(key: _formKey),
                  const SizedBox(height: 24),

                  // Obx(
                  //   () => TNavigationButton(
                  //     buttonTitle:
                  //         controller.isLoading.value ? "Loading..." : "Sign In",
                  //          isDisabled: !controller.isButtonActive,
                  //     onTap: () async {
                  //       final formState = _formKey.currentState!;
                  //       if (formState.validateAndSave()) {
                  //         final email = formState.getPhoneNumber();
                  //         await controller.login(email);
                  //       }
                  //     },
                  //   ),
                  // ),
                  Obx(
                    () => TNavigationButton(
                      buttonTitle:
                          controller.isLoading.value
                              ? "" // hide text when loading
                              : "Continue",
                      isDisabled:
                          controller.isLoading.value ||
                          !controller.isButtonActive,
                      onTap: () async {
                        if (controller.isButtonActive) {
                          controller.isLoading.value = true;

                          // Show loading for 1 second
                          await Future.delayed(const Duration(seconds: 1));

                          final formState = _formKey.currentState!;
                          if (formState.validateAndSave()) {
                            final phone = formState.getPhoneNumber();
                            await controller.login(phone);
                          }

                          controller.isLoading.value = false;
                        }
                      },
                      // Add child widget for loading indicator
                      child:
                          controller.isLoading.value
                              ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                              : null,
                    ),
                  ),

                  const SizedBox(height: 26),

                  PolicyText(),
                  // SafeArea(bottom: true, child:),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
