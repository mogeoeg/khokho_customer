

import 'package:ev/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

class TLoginForm extends StatefulWidget {
  const TLoginForm({super.key});

  @override
  TLoginFormState createState() => TLoginFormState();
}

class TLoginFormState extends State<TLoginForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final LoginAuthController controller = Get.find<LoginAuthController>();
  final TextEditingController phoneController = TextEditingController();

  bool validateAndSave() {
    final isValid = formKey.currentState?.validate() ?? false;
    return isValid;
  }

  String getPhoneNumber() => phoneController.text.trim();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const Text(
          //   "Phone Number",
          //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          // ),
          // const SizedBox(height: 8),
          Row(
            children: [
              // Prefix box: 🇮🇳 +91
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: const [
                    Text('🇮🇳', style: TextStyle(fontSize: 18)),
                    SizedBox(width: 4),
                    Text(
                      '+91',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),

              // Phone number input
              Expanded(
                child: TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, // only digits
                    LengthLimitingTextInputFormatter(10), // max 10 digits
                  ],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600, // <-- makes input text bold
                    fontSize: 16,
                  ),
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  //  maxLength: 10,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                     // return 'Enter Phone Number';
                      return null;
                    }
                    if (!RegExp(r'^[0-9]{10}$').hasMatch(value.trim())) {
                      return 'Enter a valid 10-digit mobile number';
                    }
                    return null;
                  },

                  // validator: (value) => (value == null || value.isEmpty)
                  //     ? 'Enter Phone Number'
                  //     : null,
                  decoration: InputDecoration(
                    hintText: 'Enter Phone Number',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    labelStyle: TextStyle(fontWeight: FontWeight.w600),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged:
                      (value) =>
                          controller.phoneNumber.value = value, // reactive
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
