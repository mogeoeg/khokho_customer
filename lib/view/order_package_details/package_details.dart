// ignore_for_file: avoid_print

import 'package:ev/common/button.dart';
import 'package:ev/controller/order_details_controller.dart';
import 'package:ev/helper/routes/navigation.dart';
import 'package:ev/view/order_package_details/widgets/order_receiver_details_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TReceiverScreen extends StatefulWidget {
  const TReceiverScreen({super.key});

  @override
  State<TReceiverScreen> createState() => _TReceiverScreenState();
}

class _TReceiverScreenState extends State<TReceiverScreen> {
  final orderDetailsController = Get.put(OrderDetailsController());

  final receiverNameController = TextEditingController();
  final receiverPhoneController = TextEditingController();
  final receiverEmailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  
  @override
  void initState() {
    super.initState();

    // ✅ Just update the text property, no reassignment
    receiverNameController.text = orderDetailsController.receiverName.value;
    receiverPhoneController.text = orderDetailsController.receiverPhone.value;
    receiverEmailController.text = orderDetailsController.receiverEmail.value ?? '';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Receiver Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrderReceiverDetailsForm(
              nameController: receiverNameController,
              phoneController: receiverPhoneController,
              emailController: receiverEmailController,
              formKey: _formKey,
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
          child: TNavigationButton(
            buttonTitle: "Continue",
            onTap: () {
              if (_formKey.currentState!.validate()) {
                // From receiver details form (you can pass TextEditingControllers or values via callback)
                orderDetailsController.receiverName.value =
                    receiverNameController.text;
                orderDetailsController.receiverPhone.value =
                    receiverPhoneController.text;
                orderDetailsController.receiverEmail.value =
                    receiverEmailController.text;

                orderDetailsController.saveToPrefs(); // optional

                Get.toNamed(AppRoutes.bookOrder);
              }
            },
          ),
        ),
      ),
    );
  }
}
