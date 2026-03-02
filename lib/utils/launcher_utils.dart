// lib/utils/contact_utils.dart

import 'package:ev/common/toast_message.dart';
import 'package:url_launcher/url_launcher.dart';// adjust the import path based on where ToastMessage is located

class ContactUtils {
  /// Makes a phone call to the given [phoneNumber].
  static Future<void> makeCall(String phoneNumber) async {
    if (phoneNumber.isEmpty) {
      ToastMessage.show("Phone number not available", isSuccess: false);
      return;
    }

    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      ToastMessage.show("Cannot open dialer", isSuccess: false);
    }
  }

  /// Opens WhatsApp chat with the given [phoneNumber].
  static Future<void> openWhatsApp(String phoneNumber, {String countryCode = "91"}) async {
    if (phoneNumber.isEmpty) {
      ToastMessage.show("Phone number not available", isSuccess: false);
      return;
    }

    // Remove all non-digit characters
    String cleanedNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // Add country code if missing
    if (cleanedNumber.length <= 10) {
      cleanedNumber = "$countryCode$cleanedNumber";
    }

    final Uri whatsappUrl = Uri.parse("https://wa.me/$cleanedNumber");

    try {
      if (!await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication)) {
        ToastMessage.show("Cannot open WhatsApp", isSuccess: false);
      }
    } catch (e) {
      ToastMessage.show("Something went wrong", isSuccess: false);
    }
  }
}
