// ignore_for_file: avoid_print

import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {
  var profileImage = Rx<File?>(null); // File reference

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage.value = File(pickedFile.path);
      print("✅ Image selected: ${pickedFile.path}");

      // Optional: Upload to server or save to local storage here
    } else {
      print("🚫 No image selected.");
    }
  }
}
