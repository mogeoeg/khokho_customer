import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
       // centerTitle: true, 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "1. Introduction",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "Welcome to our EV Delivery App. By using our service, you agree to comply with and be bound by the following terms and conditions.",
              ),
              SizedBox(height: 16),

              Text(
                "2. User Responsibilities",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "Users are responsible for providing accurate pickup and delivery information. Any illegal or restricted items are not allowed to be transported using our platform.",
              ),
              SizedBox(height: 16),

              Text(
                "3. Payment and Charges",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "Charges are based on distance, vehicle type, and package size. Payments must be completed before or at the time of pickup unless otherwise stated.",
              ),
              SizedBox(height: 16),

              Text(
                "4. Liability",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "We are not liable for any damages or delays caused by external factors. In case of loss or damage, our team will investigate and respond as per company policy.",
              ),
              SizedBox(height: 16),

              Text(
                "5. Privacy Policy",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "We collect basic user information to provide better services. Your data is stored securely and not shared with third parties without consent.",
              ),
              SizedBox(height: 16),

              Text(
                "6. Updates to Terms",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "These terms may be updated from time to time. Continued use of the app after changes constitutes your acceptance of the new terms.",
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
