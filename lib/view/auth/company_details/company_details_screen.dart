// ignore_for_file: avoid_print, deprecated_member_use

import 'package:ev/common/button.dart';
import 'package:ev/controller/company_details.controller.dart';
import 'package:ev/helper/routes/navigation.dart';
import 'package:ev/view/auth/company_details/widgets/company_details_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompanyDetailsScreen extends StatelessWidget {
  CompanyDetailsScreen({super.key});

  final CompanyDetailsController controller = Get.put(
    CompanyDetailsController(),
  );

  void _onSubmit() async {
    final success = await controller.submitDetails();
    if (success) {
      Get.toNamed(AppRoutes.addressDetailsScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // ❌ Prevent going back to OTP
        return false;
      },

      
      child: Scaffold(
      //  appBar: AppBar(automaticallyImplyLeading:false),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                            'Company Details',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                           'Provide your company details',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                    // TAuthHeader(
                    //   title: 'Company Details',
                    //   subTitle: 'Provide your company details',
                    // ),
                    const SizedBox(height: 32),
                    CompanyDetailsForm(),
                    const SizedBox(height: 24),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
           bottom: true,
          child: Padding(
           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: TNavigationButton(buttonTitle: "Continue", onTap: _onSubmit),
          ),
        ),
      ),
    );
  }
}
