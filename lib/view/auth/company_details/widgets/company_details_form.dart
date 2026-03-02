// ignore_for_file: avoid_print

import 'package:ev/common/required_lable_title.dart';
import 'package:ev/controller/company_details.controller.dart';
import 'package:ev/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CompanyDetailsForm extends StatelessWidget {
  final CompanyDetailsController controller =
      Get.find<CompanyDetailsController>();

  CompanyDetailsForm({super.key});

  // ================= VALIDATORS =================
  String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Enter Full Name";
    } else if (!RegExp(r"^[a-zA-Z ]+$").hasMatch(value.trim())) {
      return "Name can only contain letters";
    } else if (value.trim().length < 3) {
      return "Name must be at least 3 characters long";
    }
    return null;
  }

  String? validateCompanyName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Enter Company Name";
    } else if (value.trim().split(" ").length < 2) {
      return "Enter full company name";
    }
    return null;
  }

  String? validateGST(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Enter GST Number";
    } else if (value.trim().length != 15) {
      return "GST Number must be exactly 15 characters";
    } else if (!RegExp(
      r"^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$",
    ).hasMatch(value.trim())) {
      return "Enter valid GST Number (15 characters, correct format)";
    }
    return null;
  }

 String? validateEmail(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Enter Email ID";
  } else if (!RegExp(
    r"^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$", // only lowercase letters
  ).hasMatch(value.trim())) {
    return "Enter valid Email Address (lowercase only)";
  }
  return null;
}

  // ==============================================

  // helper method for required field label

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RequiredFieldLableTitle(label: "Full Name"),
          const SizedBox(height: 8),
          TextFormField(
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            controller: controller.nameController,
            // validator: (value) => value!.isEmpty ? 'Enter Full Name' : null,
            validator: validateFullName,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Iconsax.profile_2user5,
                size: 22,
                color: TColors.primary,
              ),
              hintText: "e.g. John Doe",

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 16),

          RequiredFieldLableTitle(label: "Company Name"),
          const SizedBox(height: 8),
          TextFormField(
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            controller: controller.companyNameController,
            // validator: (value) =>
            //     value!.isEmpty ? 'Enter Company Name' : null,
            validator: validateCompanyName,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.business,
                size: 22,
                color: TColors.primary,
              ),
              hintText: "e.g. Tesla Motors Pvt. Ltd.",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 16),

          RequiredFieldLableTitle(label: "GST Number"),
          const SizedBox(height: 8),
          TextFormField(
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            controller: controller.gstController,
            validator: validateGST,
            // validator: (value) =>
            //     value!.isEmpty ? 'Enter GST Number' : null,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.confirmation_number,
                size: 22,
                color: TColors.primary,
              ),
              hintText: "e.g. 22ABCDExxxx1Z5",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 16),

          RequiredFieldLableTitle(label: "Business Mail Address"),
          const SizedBox(height: 8),
          TextFormField(
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            controller: controller.emailController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.email, size: 22, color: TColors.primary),
              hintText: "e.g. john.doe@company.com",
              counterText: '',
            ),
            keyboardType: TextInputType.text,
            validator: validateEmail,
            // validator: (value) => value!.isEmpty ? 'Enter Email ID' : null,
          ),
        ],
      ),
    );
  }
}
