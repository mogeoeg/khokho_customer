import 'package:get/get.dart';

class HelpController extends GetxController {
  var expandedIndex = (-1).obs;
  var searchText = ''.obs;

  void toggleExpand(int index) {
    if (expandedIndex.value == index) {
      expandedIndex.value = -1; // collapse
    } else {
      expandedIndex.value = index; // expand
    }
  }

  void updateSearchText(String text) {
    searchText.value = text;
  }
}

