import 'package:flutter/material.dart';

class ConfirmationDialog {
  static Future<void> show({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (ctx) => AlertDialog(
            title: Text(title),
            content: Text(content,  style: TextStyle( fontWeight: FontWeight.w500, fontSize: 15)),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  if (onCancel != null) onCancel();
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  onConfirm();
                },
                child: const Text("Yes"),
              ),
            ],
          ),
    );
  }
}
