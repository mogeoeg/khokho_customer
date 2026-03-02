// ignore_for_file: avoid_print

import 'package:ev/utils/preference_utils.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CompanyDetailsController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final companyNameController = TextEditingController();
  final gstController = TextEditingController();
  final emailController = TextEditingController(); 

  Future<bool> submitDetails() async {
    if (!formKey.currentState!.validate()) {
      print("Validation failed");
      return false;
    }

    final name = nameController.text;
    final companyName = companyNameController.text;
    final gst = gstController.text;
    final email = emailController.text;

    await PreferenceUtils.saveUserDetails(
      name: name,
      companyName: companyName,
      gstDetails: gst,
       email: email,
    );

    print('Saved Name: $name');
    print('Saved Company: $companyName');
    print('Saved GST: $gst');
     print('Saved Email: $email'); 

     // After company details done
await PreferenceUtils.setInt('profileStep', 2);

    return true;
  }

  @override
  void onClose() {
    nameController.dispose();
    companyNameController.dispose();
    gstController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
