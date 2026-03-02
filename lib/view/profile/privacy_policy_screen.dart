import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
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
                "This Privacy Policy outlines how we collect, use, and protect your personal information when you use our EV Delivery services.",
              ),
              SizedBox(height: 16),

              Text(
                "2. Information We Collect",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "We may collect information such as your name, contact details, location, payment data, and order history to provide our services effectively.",
              ),
              SizedBox(height: 16),

              Text(
                "3. How We Use Your Data",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "Your information is used to fulfill deliveries, improve user experience, communicate updates, and ensure service quality.",
              ),
              SizedBox(height: 16),

              Text(
                "4. Data Protection",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "We implement appropriate security measures to protect your data from unauthorized access, alteration, or disclosure.",
              ),
              SizedBox(height: 16),

              Text(
                "5. Sharing of Information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "We do not share your personal data with third parties without your consent, except as required by law or for service fulfillment.",
              ),
              SizedBox(height: 16),

              Text(
                "6. Your Rights",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "You have the right to access, update, or delete your personal information. Contact our support team to request changes or revoke consent.",
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
