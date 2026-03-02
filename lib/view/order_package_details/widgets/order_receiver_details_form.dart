import 'package:ev/common/required_lable_title.dart';
import 'package:ev/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

class OrderReceiverDetailsForm extends StatefulWidget {
  final void Function(String fullPhoneNumber)? onChanged;
  final TextEditingController? nameController;
  final TextEditingController? phoneController;
  final TextEditingController? emailController;
  final GlobalKey<FormState>? formKey;

  const OrderReceiverDetailsForm({
    super.key,
    this.onChanged,
    this.nameController,
    this.phoneController,
    this.emailController,
    this.formKey,
  });

  @override
  State<OrderReceiverDetailsForm> createState() =>
      _OrderReceiverDetailsFormState();
}

class _OrderReceiverDetailsFormState extends State<OrderReceiverDetailsForm> {
  //final _formKey = GlobalKey<FormState>();
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nameController = widget.nameController ?? TextEditingController();
    phoneController = widget.phoneController ?? TextEditingController();
    emailController = widget.emailController ?? TextEditingController();
    _formKey = widget.formKey ?? GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               RequiredFieldLableTitle(label:  "Receiver Name"),
              
              const SizedBox(height: 8),

              TextFormField(
                controller: nameController,
                 style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                validator:
                    (value) => value!.isEmpty ? 'Enter Receiver Name' : null,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Iconsax.profile_2user5,
                    size: 22,
                    color: TColors.primary,
                  ),
                  hintText: 'Receiver Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               RequiredFieldLableTitle(label:   "Receiver Phone Number"),
             
              const SizedBox(height: 8),
              TextFormField(
                 style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                controller: phoneController,
                 inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, // only digits
                    LengthLimitingTextInputFormatter(10), // max 10 digits
                  ],
                keyboardType: TextInputType.number,
                maxLength: 10, // limit input to 10 digits
                decoration: InputDecoration(
                  counterText: '', // hides the character counter
                  prefixIcon: Icon(
                    Icons.phone,
                    color: TColors.primary,
                    size: 22,
                  ),
                  hintText: 'Enter 10-digit Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter Receiver Phone Number';
                  } else if (!RegExp(r'^\d{10}$').hasMatch(value.trim())) {
                    return 'Phone number must be 10 digits';
                  }
                  return null;
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "Mail Address",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          TextFormField(
             style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            // controller: emailController,
            controller: emailController,
            // Email validator
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return null; // optional field
              } else if (!RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$',
              ).hasMatch(value.trim())) {
                return 'Enter a valid email address';
              }
              return null;
            },

            decoration: InputDecoration(
              hintText: 'Enter Mail Address',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
