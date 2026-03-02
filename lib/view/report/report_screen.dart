// ignore_for_file: use_build_context_synchronously

import 'package:ev/common/toast_message.dart';
import 'package:ev/controller/report_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final TextEditingController _issueController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final ReportController reportController = Get.put(ReportController());

  Future<void> _submitReport() async {
    final reason = _reasonController.text.trim();
    final comment = _issueController.text.trim();

    if (reason.isEmpty || comment.isEmpty) {
      ToastMessage.show("Please fill all fields", isSuccess: false);

      // ScaffoldMessenger.of(
      //   context,
      // ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    final success = await reportController.submitReport(
      reason: reason,
      comment: comment,
    );

    if (!mounted) return;

    if (success) {
      _reasonController.clear();
      _issueController.clear();

       ToastMessage.show("Report submitted successfully ✅", isSuccess: true);

      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text("Report submitted successfully ✅")),
      // );
      Navigator.pop(context);
    } else {
       ToastMessage.show("Something went wrong", isSuccess: false);

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text(reportController.errorMessage.value)),
      // );
    }
  }

  Future<void> _makeSupportCall() async {
    const supportNumber = "tel:+919514232418"; // Replace with real number
    if (await canLaunchUrl(Uri.parse(supportNumber))) {
      await launchUrl(Uri.parse(supportNumber));
    } else {
      // ScaffoldMessenger.of(
      //   context,
      // ).showSnackBar(const SnackBar(content: Text("Could not open dialer")));
       ToastMessage.show("Could not open dialer", isSuccess: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Report Issue")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("Reason", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _reasonController,
              decoration: InputDecoration(
                hintText: "Enter reason (e.g. Payment issue, Rider issue)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Describe Your Issue",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _issueController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Type your issue here...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            /// Submit Button with loading state
            Obx(() {
              return ElevatedButton.icon(
                onPressed:
                    reportController.isSubmitting.value ? null : _submitReport,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                icon:
                    reportController.isSubmitting.value
                        ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                        : const Icon(Icons.send, color: Colors.white),
                label: Text(
                  reportController.isSubmitting.value
                      ? "Submitting..."
                      : "Submit",
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }),

            const SizedBox(height: 10),

            OutlinedButton.icon(
              onPressed: _makeSupportCall,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.blue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              icon: const Icon(Icons.call, color: Colors.blue),
              label: const Text(
                "Call Support",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
